import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter_hiring_exercise/globals.dart' as globals;

class AuthService {
  const AuthService();
  Future<Map<String, dynamic>> login(String email, String password) async {
    
    // service call
    final path = globals.apiURL;
    final response = await globals.httpClient.post('$path/login',
        body: {
          'email': email, 
          'password': password
        });

    final Map<String, dynamic> responseJson = json.decode(response.body);

    return responseJson;
  }
}
