import 'dart:convert';

import 'package:e_commerce/models/brand_model.dart';
import 'package:e_commerce/models/cart_model.dart';
import 'package:e_commerce/models/checkout_model.dart';
import 'package:e_commerce/models/products_model.dart';
import 'package:flutter_test/flutter_test.dart';

ProductsModel _product() => ProductsModel(
  id: 'p1',
  brandModel: BrandModel(
    id: 'b1',
    brandName: 'Nike',
    iconName: 'nike',
    productCount: 5,
  ),
  categoryId: 'c1',
  currency: 'EUR',
  productImageList: ['https://example.com/1.jpg'],
  productName: 'Air Max',
  discount: 10,
  price: 100,
  productSize: ['41', '42'],
  stock: 10,
);

void main() {
  group('ProductsModel', () {
    test('getPriceWithDiscount applies a 10% discount', () {
      expect(_product().getPriceWithDiscount, 90.0);
    });
  });

  group('CartModel', () {
    test('id combines product id and size', () {
      final cart = CartModel(productModel: _product(), size: '42');

      expect(cart.id, 'p1:42');
    });

    test('getTotalPrice is discounted price times quantity', () {
      final cart = CartModel(productModel: _product(), size: '42', quantity: 3);

      expect(cart.getTotalPrice, 270.0);
    });
  });

  group('CheckoutModel', () {
    test('toMap and fromJson round trip keeps items, postalCode and orderId', () {
      final order = CheckoutModel(
        orderId: 'order-1',
        userId: 'user-1',
        address: '10 Downing Street',
        city: 'London',
        country: 'UK',
        email: 'test@example.com',
        firstName: 'John',
        lastName: 'Doe',
        checkoutPrice: 270.0,
        postalCode: 'SW1A 1AA',
        items: [CartModel(productModel: _product(), size: '42', quantity: 3)],
        orderDate: '2026-10-27',
        orderStatus: 0,
      );

      // Encode and decode to mimic the untyped maps that come back from Firestore.
      final json =
          jsonDecode(jsonEncode(order.toMap())) as Map<String, dynamic>;
      final restored = CheckoutModel.fromJson(json);

      expect(restored.orderId, 'order-1');
      expect(restored.postalCode, 'SW1A 1AA');
      expect(restored.checkoutPrice, 270.0);
      expect(restored.deliveryDate, isNull);
      expect(restored.items, hasLength(1));
      expect(restored.items.first!.id, 'p1:42');
      expect(restored.items.first!.quantity, 3);
      expect(restored.items.first!.productModel.productName, 'Air Max');
      expect(restored.items.first!.currency, 'EUR');
    });
  });
}
