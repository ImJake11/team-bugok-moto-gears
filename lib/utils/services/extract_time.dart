import 'package:intl/intl.dart';

String extractTime(DateTime timestamp, {bool? showSeconds = false}) {
  if (showSeconds ?? false) {
    return DateFormat("h:mm:ss a").format(timestamp);
  }

  return DateFormat("h:mm a").format(timestamp);
}
