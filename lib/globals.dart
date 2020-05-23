library flutter_hiring_exercise.globals;

import 'package:http/http.dart' as http;

// global http client for a single http request instance for api calls in services as well as tests.
http.Client httpClient = http.Client();