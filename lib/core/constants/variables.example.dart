import 'package:http/http.dart' as http;

//  Remove Example naming when you use this file in current development or production.
class VariablesExample {
  static const String baseUrl = 'http://localhost:8000';
  // static const String baseUrl = 'http://192.168.0.113:8000';
  static const String imageBaseUrl = '$baseUrl/storage/';

  static http.Client httpClient = http.Client();
}
