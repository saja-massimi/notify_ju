class UserModel {

  final int? user_id;
  final String? username;
  final String? user_password;
  final String? user_email;
  final String? student_id;
  final int? user_phone_num;

  UserModel({required this.user_id, required this.username, required this.user_password, required this.user_email, required this.student_id, required this.user_phone_num});
  

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      user_id: json['user_id'],
      username: json['username'],
      user_password: json['user_password'],
      user_email: json['user_email'],
      student_id: json['student_id'],
      user_phone_num: json['user_phone_num'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': user_id,
      'username': username,
      'user_password': user_password,
      'user_email': user_email,
      'student_id': student_id,
      'user_phone_num': user_phone_num,
    };
  }

}