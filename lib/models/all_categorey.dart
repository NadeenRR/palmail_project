// To parse this JSON data, do
//
//     final allCategorey = allCategoreyFromJson(jsonString);

import 'dart:convert';

AllCategorey allCategoreyFromJson(String str) =>
    AllCategorey.fromJson(json.decode(str));

String allCategoreyToJson(AllCategorey data) => json.encode(data.toJson());

class AllCategorey {
  final List<CategoryElement>? categories;

  AllCategorey({
    this.categories,
  });

  factory AllCategorey.fromJson(Map<String, dynamic> json) => AllCategorey(
        categories: json["categories"] == null
            ? []
            : List<CategoryElement>.from(
                json["categories"]!.map((x) => CategoryElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
      };
}

class CategoryElement {
  final int? id;
  final Name? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? sendersCount;
  final List<Sender>? senders;

  CategoryElement({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.sendersCount,
    this.senders,
  });

  factory CategoryElement.fromJson(Map<String, dynamic> json) =>
      CategoryElement(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sendersCount: json["senders_count"],
        senders: json["senders"] == null
            ? []
            : List<Sender>.from(
                json["senders"]!.map((x) => Sender.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "senders_count": sendersCount,
        "senders": senders == null
            ? []
            : List<dynamic>.from(senders!.map((x) => x.toJson())),
      };
}

enum Name { FOREIGN, NG_OS, OFFICIAL_ORGANIZATIONS, OTHER }

final nameValues = EnumValues({
  "Foreign": Name.FOREIGN,
  "NGOs": Name.NG_OS,
  "Official Organizations": Name.OFFICIAL_ORGANIZATIONS,
  "Other": Name.OTHER
});

class Sender {
  final int? id;
  final String? name;
  final String? mobile;
  final String? address;
  final String? categoryId;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final SenderCategory? category;

  Sender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

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
        category: json["category"] == null
            ? null
            : SenderCategory.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "category": category?.toJson(),
      };
}

class SenderCategory {
  final int? id;
  final Name? name;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  SenderCategory({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory SenderCategory.fromJson(Map<String, dynamic> json) => SenderCategory(
        id: json["id"],
        name: nameValues.map[json["name"]]!,
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
