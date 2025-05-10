import 'package:intl/intl.dart';

String formatDate(String isoDate) {
  DateTime dateTime = DateTime.parse(isoDate);
  return "${dateTime.year}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.day.toString().padLeft(2, '0')}";
}

String formatDateWithTime (String date){
  final utcDateTime = DateTime.parse(date);
  final localDateTime = utcDateTime.toLocal();
  final formatted = DateFormat("yyyy-MM-dd hh:mm a").format(localDateTime);
  return formatted;
}