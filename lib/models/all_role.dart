// To parse this JSON data, do
//
//     final allRoles = allRolesFromJson(jsonString);

import 'dart:convert';

AllRoles allRolesFromJson(String str) => AllRoles.fromJson(json.decode(str));

String allRolesToJson(AllRoles data) => json.encode(data.toJson());

class AllRoles {
  List<Role>? roles;

  AllRoles({
    this.roles,
  });

  AllRoles copyWith({
    List<Role>? roles,
  }) =>
      AllRoles(
        roles: roles ?? this.roles,
      );

  factory AllRoles.fromJson(Map<String, dynamic> json) => AllRoles(
        roles: json["roles"] == null
            ? []
            : List<Role>.from(json["roles"]!.map((x) => Role.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "roles": roles == null
            ? []
            : List<dynamic>.from(roles!.map((x) => x.toJson())),
      };
}

class Role {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? usersCount;
  List<User>? users;

  Role({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.usersCount,
    this.users,
  });

  Role copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? usersCount,
    List<User>? users,
  }) =>
      Role(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        usersCount: usersCount ?? this.usersCount,
        users: users ?? this.users,
      );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        usersCount: json["users_count"],
        users: json["users"] == null
            ? []
            : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "users_count": usersCount,
        "users": users == null
            ? []
            : List<dynamic>.from(users!.map((x) => x.toJson())),
      };
}

class User {
  int? id;
  String? name;
  String? email;
  String? image;
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
    String? image,
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
