// To parse this JSON data, do
//
//     final changeRole = changeRoleFromJson(jsonString);

import 'dart:convert';

ChangeRole changeRoleFromJson(String str) =>
    ChangeRole.fromJson(json.decode(str));

String changeRoleToJson(ChangeRole data) => json.encode(data.toJson());

class ChangeRole {
  String? message;
  User? user;

  ChangeRole({
    this.message,
    this.user,
  });

  ChangeRole copyWith({
    String? message,
    User? user,
  }) =>
      ChangeRole(
        message: message ?? this.message,
        user: user ?? this.user,
      );

  factory ChangeRole.fromJson(Map<String, dynamic> json) => ChangeRole(
        message: json["message"],
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user": user?.toJson(),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  dynamic image;
  dynamic emailVerifiedAt;
  String? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.name,
    this.email,
    this.image,
    this.emailVerifiedAt,
    this.roleId,
    this.createdAt,
    this.updatedAt,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    dynamic image,
    dynamic emailVerifiedAt,
    String? roleId,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        image: image ?? this.image,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        roleId: roleId ?? this.roleId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
