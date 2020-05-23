import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' as Foundation;
import 'package:flutter_hiring_exercise/globals.dart' as globals;

/*
 *  API URL path config
 * if Release mode, your ip address would be used for api requests
 * if not: 10.0.2.2 for android emulators, localhost for other device
 * */ 

final apiURL = (Foundation.kReleaseMode) ? 'https://172.16.1.101' :
                  ( Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000' );

class AuthService {
  const AuthService();
  Future<Map<String, dynamic>> login(String email, String password) async {
    
    // service call
    final response = await globals.httpClient.post('$apiURL/login',
        body: {
          'email': email, 
          'password': password
        });

    final Map<String, dynamic> responseJson = json.decode(response.body);

    return responseJson;
  }
}
