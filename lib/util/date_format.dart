import 'package:intl/intl.dart';

class DateUtil {
  static String dateTimeYearFormat(DateTime val) {
    if (val == null) {
      return "";
    }
    return DateFormat('hh:mm a, dd MMM`yy').format(val);
  }
}
