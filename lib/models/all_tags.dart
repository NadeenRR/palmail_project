//
//     final allTags = allTagsFromJson(jsonString);

import 'dart:convert';

AllTags allTagsFromJson(String str) => AllTags.fromJson(json.decode(str));

String allTagsToJson(AllTags data) => json.encode(data.toJson());

class AllTags {
  List<Tag>? tags;

  AllTags({
    this.tags,
  });

  AllTags copyWith({
    List<Tag>? tags,
  }) =>
      AllTags(
        tags: tags ?? this.tags,
      );

  factory AllTags.fromJson(Map<String, dynamic> json) => AllTags(
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}

class Tag {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  bool isSelected = false;

  Tag({
    required this.isSelected,
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  Tag copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        isSelected: false,
      );

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        isSelected: false,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}
