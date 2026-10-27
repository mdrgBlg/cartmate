import 'package:e_commerce/data/models/result.dart';
import 'package:e_commerce/data/repositories/wishlist_repository.dart';
import 'package:e_commerce/data/services/wishlist_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_data.dart';

class _MockWishlistService extends Mock implements WishlistService {}

void main() {
  late _MockWishlistService wishlistService;
  late WishlistRepository repository;

  setUpAll(() {
    registerFallbackValue(testProduct());
  });

  setUp(() {
    wishlistService = _MockWishlistService();
    when(
      () => wishlistService.fetchWishlistProducts(),
    ).thenAnswer((_) async => const Success([]));
    repository = WishlistRepository(wishlistService: wishlistService);
  });

  test('toggleWishlist before load fails', () async {
    final result = await repository.toggleWishlist(testProduct());

    expect(result, isA<Failure<void>>());
    verifyNever(() => wishlistService.addProduct(any()));
  });

  test('adding succeeds and marks the product as wishlisted', () async {
    when(
      () => wishlistService.addProduct(any()),
    ).thenAnswer((_) async => const Success<void>(null));
    await repository.getWishlistProducts();

    final result = await repository.toggleWishlist(testProduct());

    expect(result, isA<Success<void>>());
    expect(repository.isWishlisted('p1'), isTrue);
  });

  test(
    'a failed add is rolled back and listeners are notified twice',
    () async {
      when(
        () => wishlistService.addProduct(any()),
      ).thenAnswer((_) async => Failure(Exception('offline')));
      await repository.getWishlistProducts();
      var notifications = 0;
      repository.addListener(() => notifications++);

      final result = await repository.toggleWishlist(testProduct());

      expect(result, isA<Failure<void>>());
      expect(repository.isWishlisted('p1'), isFalse);
      expect(notifications, 2);
    },
  );

  test('a failed remove restores the product', () async {
    when(
      () => wishlistService.fetchWishlistProducts(),
    ).thenAnswer((_) async => Success([testProduct()]));
    when(
      () => wishlistService.removeProduct(any()),
    ).thenAnswer((_) async => Failure(Exception('offline')));
    await repository.getWishlistProducts();

    final result = await repository.toggleWishlist(testProduct());

    expect(result, isA<Failure<void>>());
    expect(repository.isWishlisted('p1'), isTrue);
  });

  test('clear resets so the next load fetches again', () async {
    await repository.getWishlistProducts();
    await repository.getWishlistProducts();
    verify(() => wishlistService.fetchWishlistProducts()).called(1);

    repository.clear();
    await repository.getWishlistProducts();

    verify(() => wishlistService.fetchWishlistProducts()).called(1);
  });
}
