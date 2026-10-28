import 'dart:async';

import 'package:e_commerce/core/widgets/session_guard/providers/session_guard_provider.dart';
import 'package:e_commerce/data/models/result.dart';
import 'package:e_commerce/data/repositories/auth_repository.dart';
import 'package:e_commerce/data/repositories/cart_repository.dart';
import 'package:e_commerce/data/repositories/user_repository.dart';
import 'package:e_commerce/data/repositories/wishlist_repository.dart';
import 'package:e_commerce/data/services/firestore_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_data.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockCartRepository extends Mock implements CartRepository {}

class _MockWishlistRepository extends Mock implements WishlistRepository {}

class _MockFirestoreService extends Mock implements FirestoreService {}

void main() {
  late StreamController<String?> userIdChanges;
  late _MockAuthRepository authRepository;
  late _MockCartRepository cartRepository;
  late _MockWishlistRepository wishlistRepository;
  late UserRepository userRepository;
  late int sessionEndedCalls;
  late SessionGuardProvider provider;

  setUp(() {
    userIdChanges = StreamController<String?>();
    authRepository = _MockAuthRepository();
    cartRepository = _MockCartRepository();
    wishlistRepository = _MockWishlistRepository();
    userRepository = UserRepository(firestoreService: _MockFirestoreService());
    sessionEndedCalls = 0;

    when(
      () => authRepository.userIdChanges,
    ).thenAnswer((_) => userIdChanges.stream);
    when(
      () => cartRepository.clearCart(),
    ).thenAnswer((_) async => const Success<void>(null));

    provider = SessionGuardProvider(
      authRepository: authRepository,
      userRepository: userRepository,
      cartRepository: cartRepository,
      wishlistRepository: wishlistRepository,
      onSessionEnded: () => sessionEndedCalls++,
    );
  });

  tearDown(() => userIdChanges.close());

  test('null event with a current user ends the session', () async {
    userRepository.setCurrentUser(testUser());

    userIdChanges.add(null);
    await pumpEventQueue();

    expect(userRepository.currentUser, isNull);
    verify(() => cartRepository.clearCart()).called(1);
    verify(() => wishlistRepository.clear()).called(1);
    expect(sessionEndedCalls, 1);
    provider.dispose();
  });

  test('null event without a current user does nothing', () async {
    userIdChanges.add(null);
    await pumpEventQueue();

    verifyNever(() => cartRepository.clearCart());
    verifyNever(() => wishlistRepository.clear());
    expect(sessionEndedCalls, 0);
    provider.dispose();
  });

  test('non-null uid event does nothing', () async {
    userRepository.setCurrentUser(testUser());

    userIdChanges.add('u1');
    await pumpEventQueue();

    expect(userRepository.currentUser, isNotNull);
    verifyNever(() => cartRepository.clearCart());
    verifyNever(() => wishlistRepository.clear());
    expect(sessionEndedCalls, 0);
    provider.dispose();
  });

  test('events after dispose are ignored', () async {
    userRepository.setCurrentUser(testUser());
    provider.dispose();

    userIdChanges.add(null);
    await pumpEventQueue();

    expect(userRepository.currentUser, isNotNull);
    verifyNever(() => cartRepository.clearCart());
    verifyNever(() => wishlistRepository.clear());
    expect(sessionEndedCalls, 0);
  });
}
