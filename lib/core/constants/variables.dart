import 'package:http/http.dart' as http;

class Variables {
  static const String baseUrl = 'http://localhost:8000';
  // static const String baseUrl = 'http://192.168.0.113:8000';
  // http://192.168.1.101:8000
  static const String imageBaseUrl = '$baseUrl/storage/';

  static http.Client httpClient = http.Client();
}
