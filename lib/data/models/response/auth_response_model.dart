import 'dart:convert';

class AuthResponseModel {
  final String? message;
  final String? token;
  final User? user;

  AuthResponseModel({this.message, this.token, this.user});

  factory AuthResponseModel.fromJson(String str) => AuthResponseModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AuthResponseModel.fromMap(Map<String, dynamic> json) =>
      AuthResponseModel(message: json["message"], token: json["token"], user: json["user"] == null ? null : User.fromMap(json["user"]));

  Map<String, dynamic> toMap() => {"message": message, "token": token, "user": user?.toMap()};
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final dynamic phone;
  final String? roles;
  final dynamic emailVerifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  User({this.id, this.name, this.email, this.phone, this.roles, this.emailVerifiedAt, this.createdAt, this.updatedAt});

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    roles: json["roles"],
    emailVerifiedAt: json["email_verified_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "roles": roles,
    "email_verified_at": emailVerifiedAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
