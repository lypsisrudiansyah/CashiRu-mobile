import 'package:cashiru/core/constants/variables.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/data/models/response/auth_response_model.dart';
import 'package:dartz/dartz.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthRemoteDatasource {
  final AuthLocalDatasource _localDatasource;

  AuthRemoteDatasource({AuthLocalDatasource? localDatasource}) : _localDatasource = localDatasource ?? AuthLocalDatasource();

  Future<Either<String, AuthResponseModel>> login(String email, String password) async {
    // final response = await http.post(
    final response = await Variables.httpClient.post(
      Uri.parse('${Variables.baseUrl}/api/login'),
      headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      final authResponse = AuthResponseModel.fromJson(response.body);
      return Right(authResponse);
    } else if (response.statusCode == 422) {
      final decoded = jsonDecode(response.body);
      final errors = decoded['errors'] as Map<String, dynamic>;

      final errorMessages = errors.entries.map((e) => "${e.key}: ${(e.value as List).join(', ')}").join('\n');

      return Left('Validation failed:\n$errorMessages');
    } else {
      return Left('Login failed: ${response.reasonPhrase ?? 'Unknown error'}');
    }
  }

  Future<Either<String, AuthResponseModel>> logout() async {
    final authData = await _localDatasource.getAuthData();
    final response = await Variables.httpClient.post(
      Uri.parse('${Variables.baseUrl}/api/logout'),
      headers: {'Authorization': 'Bearer ${authData?.token}'},
    );
    if (response.statusCode == 200) {
      await _localDatasource.clearAuthData();
      return Right(AuthResponseModel(message: 'Logout successful'));
    } else {
      return Left('Logout failed: ${response.reasonPhrase ?? response.statusCode}');
    }
  }
}
