import 'package:intl/intl.dart';

extension PriceFormat on num {
  /// Formats with the symbol of the ISO 4217 [currency] code, e.g. `€90.00`.
  String formatPrice(String currency, {String? locale}) {
    final NumberFormat formatter = NumberFormat.simpleCurrency(
      locale: locale,
      name: currency,
    );
    return formatter.format(this);
  }
}
