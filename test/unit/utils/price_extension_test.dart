import 'package:e_commerce/utils/extensions/price_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatPrice', () {
    test('formats a price with the currency symbol', () {
      expect(90.0.formatPrice('EUR', locale: 'en'), '€90.00');
    });

    test('rounds to two decimals', () {
      expect(89.99999.formatPrice('EUR', locale: 'en'), '€90.00');
    });

    test('formats an integer price', () {
      expect(100.formatPrice('EUR', locale: 'en'), '€100.00');
    });
  });
}
