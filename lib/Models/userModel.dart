// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {

  final String? user_id;
  final String username;
  final String user_email;
  final String student_id;
  final String user_phone_num;
  final String? role;

  UserModel( {
    this.user_id,
    required this.username,
    required this.user_email, 
    required this.student_id, 
    required this.user_phone_num,
    this.role
    });
  
  toJson() {
    return {
      "username": username,
      "user_email": user_email,
      "student_id": student_id,
      "user_phone_num": user_phone_num,
      "role": role
    };
  }



  factory UserModel.fromJSnapshot(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data();
    return UserModel(
      user_id: doc.id,
      username: data!['username'],
      user_email: data['user_email'],
      student_id: data['student_id'],
      user_phone_num: data['user_phone_num'],
      role: data['role'],
    );
  }

}