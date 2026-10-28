import 'package:e_commerce/data/models/result.dart';
import 'package:e_commerce/data/repositories/auth_repository.dart';
import 'package:e_commerce/data/services/api_service.dart';
import 'package:e_commerce/data/services/auth_service.dart';
import 'package:e_commerce/data/services/firebase_service.dart';
import 'package:e_commerce/data/models/user_info_model.dart';
import 'package:e_commerce/utils/global_enums.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_data.dart';

class _MockFirebaseService extends Mock implements FirebaseService {}

class _MockAuthService extends Mock implements AuthService {}

class _MockApiService extends Mock implements ApiService {}

void main() {
  late _MockAuthService authService;
  late _MockApiService apiService;
  late AuthRepository repository;

  setUpAll(() {
    registerFallbackValue(testUser());
  });

  setUp(() {
    authService = _MockAuthService();
    apiService = _MockApiService();
    when(
      () => authService.signOut(),
    ).thenAnswer((_) async => const Success<void>(null));
    repository = AuthRepository(
      firebaseService: _MockFirebaseService(),
      authService: authService,
      apiService: apiService,
    );
  });

  Future<Result<UserInfoModel>> signUp() => repository.signUp(
    email: 'test@example.com',
    password: 'secret123',
    firstName: 'John',
    lastName: 'Doe',
    username: 'johndoe',
    phoneNumber: '+381600000000',
    dateOfBirth: DateTime(1990, 5, 20),
    gender: Gender.male,
  );

  group('login', () {
    test('signs out and fails when the profile fetch fails', () async {
      when(
        () => authService.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Success('u1'));
      when(
        () => apiService.fetchUserInfo('u1'),
      ).thenAnswer((_) async => Failure(Exception('not found')));

      final result = await repository.login(
        email: 'test@example.com',
        password: 'secret123',
      );

      expect(result, isA<Failure<UserInfoModel>>());
      verify(() => authService.signOut()).called(1);
    });

    test('passes a sign-in failure through unchanged', () async {
      final exception = Exception('wrong password');
      when(
        () => authService.signIn(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => Failure(exception));

      final result = await repository.login(
        email: 'test@example.com',
        password: 'wrong',
      );

      expect(result, isA<Failure<UserInfoModel>>());
      expect((result as Failure<UserInfoModel>).exception, same(exception));
      verifyNever(() => apiService.fetchUserInfo(any()));
      verifyNever(() => authService.signOut());
    });
  });

  group('signUp', () {
    setUp(() {
      when(
        () => authService.signUp(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Success('u1'));
      when(
        () => apiService.saveUserData(any()),
      ).thenAnswer((_) async => Failure(Exception('write denied')));
    });

    test('deletes the new user when the profile save fails', () async {
      when(
        () => authService.deleteCurrentUser(),
      ).thenAnswer((_) async => const Success<void>(null));

      final result = await signUp();

      expect(result, isA<Failure<UserInfoModel>>());
      verify(() => authService.deleteCurrentUser()).called(1);
      verifyNever(() => authService.signOut());
    });

    test('signs out when deleting the new user also fails', () async {
      when(
        () => authService.deleteCurrentUser(),
      ).thenAnswer((_) async => Failure(Exception('requires recent login')));

      final result = await signUp();

      expect(result, isA<Failure<UserInfoModel>>());
      verify(() => authService.deleteCurrentUser()).called(1);
      verify(() => authService.signOut()).called(1);
    });
  });
}
