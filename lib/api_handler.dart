
import 'dart:convert';

import 'package:notify_ju/Models/userModel.dart';
import 'package:http/http.dart' as http;
class ApiHandler{
final String baseUrl= "http://localhost:7012/api/UserModel";

  Future<Object> fetchUser() async{

    List<UserModel> data = [];


  final uri = Uri.parse(baseUrl);
    try {
      final response = await http.get(
        uri,
        headers: <String, String>{
          'Content-type': 'application/json; charset=UTF-8',
        },
      );

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        final List<dynamic> jsonData = json.decode(response.body);
        data = jsonData.map((json) => UserModel.fromJson(json)).toList();
      }
    } catch (e) {
      return e.toString();
    }
    return data;
  }


}