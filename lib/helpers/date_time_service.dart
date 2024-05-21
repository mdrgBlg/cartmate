import 'package:intl/intl.dart';

class DateTimeService {
  static String formatDateTime(String? dateString) {
    //from given data string or from current date
    DateTime date = DateTime.parse(
      dateString ?? DateTime.now().toString(),
    );
    final DateFormat formatter = DateFormat('dd MMM yyyy');
    return formatter.format(date);
  }
}
