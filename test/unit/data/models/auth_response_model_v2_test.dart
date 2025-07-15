import 'package:cashiru/data/models/response/auth_response_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User model', () {
    test('fromMap should parse correctly with full data', () {
      final map = {
        "id": 1,
        "name": "John Doe",
        "email": "john@example.com",
        "phone": "12345678",
        "roles": "user",
        "email_verified_at": null,
        "created_at": "2024-01-01T12:00:00.000Z",
        "updated_at": "2024-01-02T12:00:00.000Z",
      };

      final user = User.fromMap(map);

      expect(user.id, 1);
      expect(user.name, "John Doe");
      expect(user.email, "john@example.com");
      expect(user.createdAt, DateTime.parse("2024-01-01T12:00:00.000Z"));
      expect(user.updatedAt, DateTime.parse("2024-01-02T12:00:00.000Z"));
    });

    test('toMap should convert to correct map', () {
      final user = User(
        id: 1,
        name: "John",
        email: "john@example.com",
        phone: "1234",
        roles: "user",
        createdAt: DateTime.utc(2024, 01, 01),
        updatedAt: DateTime.utc(2024, 01, 02),
      );

      final map = user.toMap();

      expect(map["id"], 1);
      expect(map["name"], "John");
      expect(map["created_at"], "2024-01-01T00:00:00.000Z");
    });

    test('User.fromMap throws FormatException when created_at is invalid', () {
      final invalidMap = {
        "id": 1,
        "name": "Invalid Date User",
        "email": "invalid@example.com",
        "created_at": "not-a-date",
        "updated_at": "2024-01-01T00:00:00.000Z",
      };

      expect(() => User.fromMap(invalidMap), throwsA(isA<FormatException>()));
    });
  });

  group('AuthResponseModel', () {
    test('fromMap should parse correctly including nested User', () {
      final map = {
        "message": "Success",
        "token": "abc123",
        "user": {
          "id": 2,
          "name": "Alice",
          "email": "alice@example.com",
          "created_at": "2024-05-01T10:00:00.000Z",
          "updated_at": "2024-05-02T10:00:00.000Z",
        },
      };

      final auth = AuthResponseModel.fromMap(map);

      expect(auth.message, "Success");
      expect(auth.token, "abc123");
      expect(auth.user?.name, "Alice");
    });

    test('toMap should serialize correctly with nested User', () {
      final user = User(
        id: 2,
        name: "Alice",
        email: "alice@example.com",
        createdAt: DateTime.utc(2024, 05, 01),
        updatedAt: DateTime.utc(2024, 05, 02),
      );

      final auth = AuthResponseModel(message: "Logged in", token: "xyz789", user: user);

      final map = auth.toMap();

      expect(map["message"], "Logged in");
      expect(map["user"]["name"], "Alice");
      expect(map["user"]["created_at"], "2024-05-01T00:00:00.000Z");
    });
  });
}
