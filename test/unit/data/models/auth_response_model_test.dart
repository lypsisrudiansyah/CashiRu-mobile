// Dart
import 'package:flutter_test/flutter_test.dart';
import 'package:cashiru/data/models/response/auth_response_model.dart';

void main() {
  group('User model', () {
    final userMap = {
      "id": 1,
      "name": "John Doe",
      "email": "john@example.com",
      "phone": "123456789",
      "roles": "user",
      "email_verified_at": null,
      "created_at": "2024-06-01T12:00:00.000",
      "updated_at": "2024-06-02T12:00:00.000",
    };

    test('fromMap creates correct User', () {
      final user = User.fromMap(userMap);
      expect(user.id, 1);
      expect(user.name, "John Doe");
      expect(user.email, "john@example.com");
      expect(user.phone, "123456789");
      expect(user.roles, "user");
      expect(user.emailVerifiedAt, null);
      expect(user.createdAt, DateTime.parse("2024-06-01T12:00:00.000"));
      expect(user.updatedAt, DateTime.parse("2024-06-02T12:00:00.000"));
    });

    test('toMap outputs correct map', () {
      final user = User.fromMap(userMap);
      final map = user.toMap();
      expect(map["id"], 1);
      expect(map["name"], "John Doe");
      expect(map["email"], "john@example.com");
      expect(map["phone"], "123456789");
      expect(map["roles"], "user");
      expect(map["email_verified_at"], null);
      expect(map["created_at"], "2024-06-01T12:00:00.000");
      expect(map["updated_at"], "2024-06-02T12:00:00.000");
    });

    test('fromJson and toJson round-trip', () {
      final user = User.fromMap(userMap);
      final jsonStr = user.toJson();
      final user2 = User.fromJson(jsonStr);
      expect(user2.id, user.id);
      expect(user2.name, user.name);
      expect(user2.email, user.email);
      expect(user2.phone, user.phone);
      expect(user2.roles, user.roles);
      expect(user2.emailVerifiedAt, user.emailVerifiedAt);
      expect(user2.createdAt, user.createdAt);
      expect(user2.updatedAt, user.updatedAt);
    });

    test('fromMap handles nulls', () {
      final user = User.fromMap({});
      expect(user.id, null);
      expect(user.name, null);
      expect(user.email, null);
      expect(user.phone, null);
    });
  });

  group('AuthResponseModel', () {
    final authMap = {
      "message": "Success",
      "token": "abc123",
      "user": {
        "id": 2,
        "name": "Jane Doe",
        "email": "jane@example.com",
        "phone": "987654321",
        "roles": "admin",
        "email_verified_at": null,
        "created_at": "2024-06-03T12:00:00.000",
        "updated_at": "2024-06-04T12:00:00.000",
      }
    };

    test('fromMap creates correct AuthResponseModel', () {
      final auth = AuthResponseModel.fromMap(authMap);
      expect(auth.message, "Success");
      expect(auth.token, "abc123");
      expect(auth.user, isNotNull);
      expect(auth.user!.id, 2);
      expect(auth.user!.name, "Jane Doe");
    });

    test('toMap outputs correct map', () {
      final auth = AuthResponseModel.fromMap(authMap);
      final map = auth.toMap();
      expect(map["message"], "Success");
      expect(map["token"], "abc123");
      expect(map["user"], isA<Map>());
      expect(map["user"]["id"], 2);
    });

    test('fromJson and toJson round-trip', () {
      final auth = AuthResponseModel.fromMap(authMap);
      final jsonStr = auth.toJson();
      final auth2 = AuthResponseModel.fromJson(jsonStr);
      expect(auth2.message, auth.message);
      expect(auth2.token, auth.token);
      expect(auth2.user!.id, auth.user!.id);
      expect(auth2.user!.name, auth.user!.name);
    });

    test('fromMap handles null user', () {
      final auth = AuthResponseModel.fromMap({
        "message": "No user",
        "token": "xyz789",
        "user": null,
      });
      expect(auth.message, "No user");
      expect(auth.token, "xyz789");
      expect(auth.user, null);
    });

    test('fromMap handles missing fields', () {
      final auth = AuthResponseModel.fromMap({});
      expect(auth.message, null);
      expect(auth.token, null);
      expect(auth.user, null);
    });
  });
}