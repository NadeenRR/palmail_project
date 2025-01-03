// To parse this JSON data, do
//
//     final createSender = createSenderFromJson(jsonString);

import 'dart:convert';

CreateSender createSenderFromJson(String str) =>
    CreateSender.fromJson(json.decode(str));

String createSenderToJson(CreateSender data) => json.encode(data.toJson());

class CreateSender {
  String? message;
  List<Sender>? sender;

  CreateSender({
    this.message,
    this.sender,
  });

  CreateSender copyWith({
    String? message,
    List<Sender>? sender,
  }) =>
      CreateSender(
        message: message ?? this.message,
        sender: sender ?? this.sender,
      );

  factory CreateSender.fromJson(Map<String, dynamic> json) => CreateSender(
        message: json["message"],
        sender: json["sender"] == null
            ? []
            : List<Sender>.from(json["sender"]!.map((x) => Sender.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "sender": sender == null
            ? []
            : List<dynamic>.from(sender!.map((x) => x.toJson())),
      };
}

class Sender {
  int? id;
  String? name;
  String? mobile;
  dynamic address;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? mailsCount;
  Category? category;

  Sender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.mailsCount,
    this.category,
  });

  Sender copyWith({
    int? id,
    String? name,
    String? mobile,
    dynamic address,
    int? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? mailsCount,
    Category? category,
  }) =>
      Sender(
        id: id ?? this.id,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        address: address ?? this.address,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        mailsCount: mailsCount ?? this.mailsCount,
        category: category ?? this.category,
      );

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        categoryId: json["category_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        mailsCount: json["mails_count"],
        category: json["category"] == null
            ? null
            : Category.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "mails_count": mailsCount,
        "category": category?.toJson(),
      };
}

class Category {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;

  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  Category copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Category(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"],
        name: json["name"],
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
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
