import 'package:cloud_firestore/cloud_firestore.dart';

String formatData(Timestamp time) {
  DateTime dateTime = time.toDate();
  String month = dateTime.month.toString().padLeft(2, '0');
  String day = dateTime.day.toString().padLeft(2, '0');

  String formattedData = '$day/$month';
  return formattedData;
}
