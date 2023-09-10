import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';

class API {
  /// local dev environment
  // static final String _url = "http://127.0.0.1:5000/api=";
  /// dev environment
  static const String DEV_API_URL = "http://192.168.1.126:1338/";
  static const String PROD_API_URL = "http://192.168.1.113:1338/";
  static String _url = PROD_API_URL;

  static Future<Response> login(String email, String password) async {
    if (kDebugMode) {
      print(_url + "user/login");
    }
    final url = Uri.parse(_url + "user/login");
    final response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode != 200) {
      print('Error: ${response.statusCode}');
      print('Response data: ${response.body.runtimeType}');
    }

    return response;
  }

  static Future<Response> register(
      String firstName,
      String lastName,
      String email,
      String password,
      String scoutGroup,
      String birthDate) async {
    if (kDebugMode) {
      print(_url + "user/register");
    }
    final url = Uri.parse(_url + "user/register");
    final response = await post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'scout_group': scoutGroup,
        'birth_date': birthDate,
      }),
    );

    if (response.statusCode != 200) {
      print('Error: ${response.statusCode}');
      print('Response data: ${response.body.runtimeType}');
    }

    return response;
  }
}
