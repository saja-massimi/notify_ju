// ignore_for_file: non_constant_identifier_names

class adminModel {

final int  admin_id;
final String admin_username;
final String email;
final String password;
final int admin_phoneNumber;

  adminModel({
  required this.admin_id, 
  required this.admin_username, 
  required this.email, 
  required this.password,
  required this.admin_phoneNumber});

Map<String, dynamic> toJson() {
    return {
      'admin_id': admin_id,
      'admin_username': admin_username,
      'email': email,
      'admin_phoneNumber': admin_phoneNumber,
    };
  }

  factory adminModel.fromJson(Map<String, dynamic> json) {
    return adminModel(
      admin_id: json['admin_id'],
      admin_username: json['admin_username'],
      email: json['email'],
      password: json['password'],
      admin_phoneNumber: json['admin_phoneNumber'],
    );
  }
}