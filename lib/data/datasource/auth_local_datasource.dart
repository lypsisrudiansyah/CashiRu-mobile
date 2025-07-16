import 'package:cashiru/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLocalDatasource {
  //save auth data
  Future<void> saveAuthData(AuthResponseModel authResponse) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authxx0_data', authResponse.toJson());
  }

  Future<AuthResponseModel?> getAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    final authData = prefs.getString('authxx0_data');
    if (authData != null) {
      return AuthResponseModel.fromJson(authData);
    }
    return null;
  }

  Future<bool> isAuthenticated() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('authxx0_data');
  }

  Future<void> clearAuthData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authxx0_data');
  }
}
