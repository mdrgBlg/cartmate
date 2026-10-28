import 'package:e_commerce/data/models/result.dart';
import 'package:e_commerce/data/repositories/user_repository.dart';
import 'package:e_commerce/data/services/api_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_data.dart';

class _MockApiService extends Mock implements ApiService {}

void main() {
  late _MockApiService apiService;
  late UserRepository repository;

  setUp(() {
    apiService = _MockApiService();
    repository = UserRepository(apiService: apiService);
  });

  group('updateName', () {
    test('updates the current user and notifies on success', () async {
      when(
        () => apiService.updateUserName('u1', 'Jane', 'Smith'),
      ).thenAnswer((_) async => const Success<void>(null));
      repository.setCurrentUser(testUser());
      var notifications = 0;
      repository.addListener(() => notifications++);

      final result = await repository.updateName('Jane', 'Smith');

      expect(result, isA<Success<void>>());
      expect(repository.currentUser?.firstName, 'Jane');
      expect(repository.currentUser?.lastName, 'Smith');
      expect(repository.currentUser?.username, 'johndoe');
      expect(notifications, 1);
    });

    test('leaves the current user unchanged on failure', () async {
      when(
        () => apiService.updateUserName('u1', 'Jane', 'Smith'),
      ).thenAnswer((_) async => Failure(Exception('offline')));
      repository.setCurrentUser(testUser());
      var notifications = 0;
      repository.addListener(() => notifications++);

      final result = await repository.updateName('Jane', 'Smith');

      expect(result, isA<Failure<void>>());
      expect(repository.currentUser?.firstName, 'John');
      expect(repository.currentUser?.lastName, 'Doe');
      expect(notifications, 0);
    });

    test('fails without a current user', () async {
      final result = await repository.updateName('Jane', 'Smith');

      expect(result, isA<Failure<void>>());
      verifyNever(() => apiService.updateUserName(any(), any(), any()));
    });
  });
}
