import 'package:cloud_firestore/cloud_firestore.dart';

String formatData(Timestamp time) {
  DateTime dateTime = time.toDate();
  // String year = dateTime.year.toString();
  String month = dateTime.month
      .toString()
      .padLeft(2, '0'); // Pad left with zero if single digit
  String day = dateTime.day
      .toString()
      .padLeft(2, '0'); // Pad left with zero if single digit

  String formattedData = '$day/$month';
  return formattedData;
}
