// To parse this JSON data, do
//
//     final createTag = createTagFromJson(jsonString);

import 'dart:convert';

CreateTag createTagFromJson(String str) => CreateTag.fromJson(json.decode(str));

String createTagToJson(CreateTag data) => json.encode(data.toJson());

class CreateTag {
  String? message;
  Tag? tag;

  CreateTag({
    this.message,
    this.tag,
  });

  CreateTag copyWith({
    String? message,
    Tag? tag,
  }) =>
      CreateTag(
        message: message ?? this.message,
        tag: tag ?? this.tag,
      );

  factory CreateTag.fromJson(Map<String, dynamic> json) => CreateTag(
        message: json["message"],
        tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "tag": tag?.toJson(),
      };
}

class Tag {
  String? name;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Tag({
    this.name,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Tag copyWith({
    String? name,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      Tag(
        name: name ?? this.name,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        name: json["name"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
