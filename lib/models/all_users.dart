// To parse this JSON data, do
//
//     final allUsers = allUsersFromJson(jsonString);

import 'dart:convert';

AllUsers allUsersFromJson(String str) => AllUsers.fromJson(json.decode(str));

String allUsersToJson(AllUsers data) => json.encode(data.toJson());

class AllUsers {
    List<User>? users;

    AllUsers({
        this.users,
    });

    factory AllUsers.fromJson(Map<String, dynamic> json) => AllUsers(
        users: json["users"] == null ? [] : List<User>.from(json["users"]!.map((x) => User.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "users": users == null ? [] : List<dynamic>.from(users!.map((x) => x.toJson())),
    };
}

class User {
    int? id;
    String? name;
    String? email;
    String? image;
    String? emailVerifiedAt;
    String? roleId;
    String? createdAt;
    String? updatedAt;
    Role? role;

    User({
        this.id,
        this.name,
        this.email,
        this.image,
        this.emailVerifiedAt,
        this.roleId,
        this.createdAt,
        this.updatedAt,
        this.role,
    });

    factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        role: json["role"] == null ? null : Role.fromJson(json["role"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "image": image,
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "role": role?.toJson(),
    };
}

class Role {
    int? id;
    String? name;
    String? createdAt;
    String? updatedAt;

    Role({
        this.id,
        this.name,
        this.createdAt,
        this.updatedAt,
    });

    factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
