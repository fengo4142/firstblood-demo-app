library flutter_hiring_exercise.globals;

import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' as Foundation;
import 'package:http/http.dart' as http;

/*
 *  API URL path config
 * if Release mode, your ip address would be used for api requests
 * if not: 10.0.2.2 for android emulators, localhost for other device
 * */ 

final apiURL = (Foundation.kReleaseMode) ? 'https://172.16.1.101' :
                  ( Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000' );

// global http client for a single http request instance for api calls in services as well as tests.
http.Client httpClient = http.Client();
