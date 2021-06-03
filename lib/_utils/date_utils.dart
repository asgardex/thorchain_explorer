import 'package:intl/intl.dart';

String unixDateStringToDisplay(String date, DateFormat df) {
  final unixInt = int.tryParse(date);
  if (unixInt == null) {
    return '';
  } else {
    final firstAddedDate =
        new DateTime.fromMillisecondsSinceEpoch(unixInt * 1000);
    return df.format(firstAddedDate);
  }
}
