import 'package:intl/intl.dart';

String convertDateStringToDate(DateTime date) {
  String formattedDate = DateFormat('MMMM dd, yyyy').format(date);

  return formattedDate;
}
