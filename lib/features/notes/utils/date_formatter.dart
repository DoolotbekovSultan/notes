import 'package:intl/intl.dart';

final DateFormatter dateFormatter = DateFormatter();

class DateFormatter {
  final String locale;

  DateFormatter({this.locale = 'ru'});

  String format(DateTime dateTime) {
    final formatter = DateFormat('d MMMM HH:mm', locale);
    return formatter.format(dateTime);
  }
}
