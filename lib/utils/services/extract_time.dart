import 'package:intl/intl.dart';

String extractTime(DateTime timestamp) {
  final formattedTime = DateFormat("hh:mm:ss a").format(timestamp);

  return formattedTime;
}
