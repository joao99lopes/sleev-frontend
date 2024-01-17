import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class API {
  static const String DEV_API_URL = "http://192.168.1.126:1338/";
  static const String PROD_API_URL = "http://192.168.1.113:1338/";
  static const String _url = PROD_API_URL;
  static BuildContext? context; // Store the BuildContext

  // Initialize the API class with the current context
  static void initialize(BuildContext buildContext) {
    context = buildContext;
  }

  // Use a shared private function to perform network requests with Dio
  static Future<Response> _sendRequest(
    String endpoint,
    Map<String, dynamic> bodyData,
  ) async {
    if (kDebugMode) {
      print(_url + endpoint);
    }

    final dio = Dio();
    try {
      final response = await dio.post(
        _url + endpoint,
        data: bodyData,
        options: Options(
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
        ),
      );

      return response;
    } on DioError catch (e) {
      if (e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.sendTimeout ||
          e.type == DioErrorType.receiveTimeout) {
        // Handle network timeout errors
        handleNetworkError();
      } else if (e.type == DioErrorType.response) {
        // Handle other response-related errors
        print('Error: ${e.response?.statusCode}');
      } else {
        // Handle other Dio errors
        print('Dio Error: $e');
      }

      // Return a custom response with an error code
      return Response(
          requestOptions: RequestOptions(path: _url + endpoint, data: bodyData),
          statusCode: 503);
    }
  }

  // Define a function to handle network errors
  static void handleNetworkError() {
    // Display a warning message as a SnackBar
    if (context != null) {
      final scaffoldMessenger = ScaffoldMessenger.of(context!);
      scaffoldMessenger.showSnackBar(
        const SnackBar(
          content: Text('No internet connection. Please check your network.'),
          duration: Duration(seconds: 3), // Adjust duration as needed
        ),
      );
    }
  }

  static Future<Response> login(String email, String password) async {
    final bodyData = <String, dynamic>{
      'email': email,
      'password': password,
    };

    return _sendRequest("user/login", bodyData);
  }

  static Future<Response> register(
    String firstName,
    String lastName,
    String email,
    String password,
    String scoutGroup,
    String birthDate,
  ) async {
    final bodyData = <String, dynamic>{
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'password': password,
      'scout_group': scoutGroup,
      'birth_date': birthDate,
    };

    return _sendRequest("user/register", bodyData);
  }
}
