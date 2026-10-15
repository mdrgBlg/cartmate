import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatDateTime() {
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(this);
  }
}
