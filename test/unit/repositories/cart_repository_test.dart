import 'package:e_commerce/data/models/result.dart';
import 'package:e_commerce/data/repositories/cart_repository.dart';
import 'package:e_commerce/data/services/cart_service.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helpers/test_data.dart';

class _MockCartService extends Mock implements CartService {}

/// Lets queued database writes run.
Future<void> _flushWrites() => Future<void>.delayed(Duration.zero);

void main() {
  late _MockCartService cartService;
  late CartRepository repository;

  setUpAll(() {
    registerFallbackValue(CartModel(productModel: testProduct(), size: '42'));
  });

  setUp(() {
    cartService = _MockCartService();
    when(
      () => cartService.saveItem(any()),
    ).thenAnswer((_) async => const Success<void>(null));
    when(
      () => cartService.deleteItem(any()),
    ).thenAnswer((_) async => const Success<void>(null));
    when(
      () => cartService.clearCart(),
    ).thenAnswer((_) async => const Success<void>(null));
    repository = CartRepository(cartService: cartService);
  });

  test('adding the same product and size twice keeps one line', () async {
    repository
      ..addProductToCart(CartModel(productModel: testProduct(), size: '42'))
      ..addProductToCart(CartModel(productModel: testProduct(), size: '42'));
    await _flushWrites();

    expect(repository.cartProducts, hasLength(1));
    expect(repository.cartProducts.single.quantity, 2);
    verify(() => cartService.saveItem(any())).called(2);
  });

  test('removing down to 0 removes the line and deletes it', () async {
    final item = CartModel(productModel: testProduct(), size: '42');
    repository
      ..addProductToCart(item)
      ..removeProductFromCart(
        CartModel(productModel: testProduct(), size: '42'),
      );
    await _flushWrites();

    expect(repository.cartProducts, isEmpty);
    final deleted =
        verify(() => cartService.deleteItem(captureAny())).captured.single
            as CartModel;
    expect(deleted.id, 'p1:42');
  });

  test('clearCart empties the cart and clears storage', () async {
    repository.addProductToCart(
      CartModel(productModel: testProduct(), size: '42'),
    );

    final result = await repository.clearCart();

    expect(result, isA<Success<void>>());
    expect(repository.cartProducts, isEmpty);
    expect(repository.cartProductNumber, 0);
    verify(() => cartService.clearCart()).called(1);
  });

  test('checkoutPrice sums discounted totals', () {
    repository
      ..addProductToCart(CartModel(productModel: testProduct(), size: '42'))
      ..addProductToCart(CartModel(productModel: testProduct(), size: '42'))
      ..addProductToCart(CartModel(productModel: testProduct(), size: '41'));

    // 90.0 per item after the 10% discount.
    expect(repository.checkoutPrice, 270.0);
  });

  test('loadCart replaces the contents', () async {
    repository.addProductToCart(
      CartModel(productModel: testProduct(), size: '42'),
    );
    when(() => cartService.fetchCart()).thenAnswer(
      (_) async => Success([
        CartModel(
          productModel: testProduct(id: 'p2'),
          size: '41',
          quantity: 3,
        ),
      ]),
    );

    final result = await repository.loadCart();

    expect(result, isA<Success<void>>());
    expect(repository.cartProducts.map((item) => item.id), ['p2:41']);
    expect(repository.cartProducts.single.quantity, 3);
  });
}
