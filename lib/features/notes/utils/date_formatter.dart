import 'package:intl/intl.dart';

final DateTimeFormatter dateTimeFormatter = DateTimeFormatter();

class DateTimeFormatter {
  final String locale;

  DateTimeFormatter({this.locale = 'ru'});

  String dateTime(DateTime dateTime) {
    final formatter = DateFormat('d MMMM HH:mm', locale);
    return formatter.format(dateTime);
  }

  String time(DateTime dateTime) {
    final formatter = DateFormat('HH:mm', locale);
    return formatter.format(dateTime);
  }

  String date(DateTime dateTime) {
    final formatter = DateFormat('d MMMM', locale);
    return formatter.format(dateTime);
  }
}
