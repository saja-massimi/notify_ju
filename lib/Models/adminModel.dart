// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class adminModel {

final String  admin_id;
final String admin_name;
final String email;
final String admin_phone_num;
final String role ;
final String? token;

  adminModel({
  required this.admin_id, 
  required this.admin_name, 
  required this.email, 
  required this.admin_phone_num,
  required this.role,
   this.token});

toJson() {
    return {
      'admin_id': admin_id,
      'admin_name': admin_name,
      'user_email': email,
      'admin_phone_num': admin_phone_num,
      'role': role,
      'fcmToken': token ?? '',
      
    };
  }

  factory adminModel.fromJsonSnapshot(DocumentSnapshot< Map<String, dynamic>> doc) {
    final data = doc.data();
    return adminModel(
      admin_id: doc.id,
      admin_name: data!['admin_name'],
      email: data['user_email'],
      admin_phone_num: data['admin_phone_num'],
      role: data['role'],
      token: data['fcmToken'],
    );
  }
}