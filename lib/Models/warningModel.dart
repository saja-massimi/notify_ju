import 'package:cloud_firestore/cloud_firestore.dart';

class WarningModel {
  String id;
  String message;
  DateTime timestamp;
  String subAdminEmail;

  WarningModel({
    required this.id,
    required this.message, 
    required this.timestamp,
    required this.subAdminEmail,});


  toJson() {
    return {
      'id': id,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'AdminEmail': subAdminEmail
    };
  }
  
  factory WarningModel.fromJSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return WarningModel(
      id: data!['id'],
      message: data['message'],
      timestamp: DateTime.parse(data['timestamp']),
      subAdminEmail: data['AdminEmail'],
    );
  }

}