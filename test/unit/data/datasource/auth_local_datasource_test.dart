import 'package:flutter_test/flutter_test.dart';
import 'package:cashiru/data/datasource/auth_local_datasource.dart';
import 'package:cashiru/data/models/response/auth_response_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late AuthLocalDatasource datasource;
  late AuthResponseModel dummyAuth;

  setUp(() {
    SharedPreferences.setMockInitialValues({});
    datasource = AuthLocalDatasource();
    dummyAuth = AuthResponseModel(message: "ok", token: "abc", user: null);
  });

  test('saveAuthData stores data in SharedPreferences', () async {
    await datasource.saveAuthData(dummyAuth);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString('authxx0_data'), dummyAuth.toJson());
  });

  test('getAuthData returns AuthResponseModel if data exists', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authxx0_data', dummyAuth.toJson());
    final result = await datasource.getAuthData();
    expect(result?.token, dummyAuth.token);
    expect(result?.message, dummyAuth.message);
  });

  test('getAuthData returns null if no data', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authxx0_data');
    final result = await datasource.getAuthData();
    expect(result, isNull);
  });

  test('isAuthenticated returns true if data exists', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authxx0_data', dummyAuth.toJson());
    final result = await datasource.isAuthenticated();
    expect(result, isTrue);
  });

  test('isAuthenticated returns false if no data', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('authxx0_data');
    final result = await datasource.isAuthenticated();
    expect(result, isFalse);
  });

  test('clearAuthData removes data from SharedPreferences', () async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authxx0_data', dummyAuth.toJson());
    await datasource.clearAuthData();
    expect(prefs.getString('authxx0_data'), isNull);
  });

  test('getAuthData returns AuthResponseModel with user data', () async {
    final userMap = {
      "id": 1,
      "name": "Test User",
      "email": "test@email.com",
      "phone": "08123456789",
      "roles": "admin",
      "email_verified_at": null,
      "created_at": "2024-07-16T10:00:00.000Z",
      "updated_at": "2024-07-16T10:00:00.000Z",
    };
    final authWithUser = AuthResponseModel(message: "ok", token: "abc", user: User.fromMap(userMap));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('authxx0_data', authWithUser.toJson());

    final result = await datasource.getAuthData();
    expect(result?.user, isNotNull);
    expect(result?.user?.id, 1);
    expect(result?.user?.name, "Test User");
    expect(result?.user?.email, "test@email.com");
    expect(result?.user?.roles, "admin");
  });
}
