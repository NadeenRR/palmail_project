// To parse this JSON data, do
//     final allStatues = allStatuesFromJson(jsonString);

import 'dart:convert';

AllStatues allStatuesFromJson(String str) =>
    AllStatues.fromJson(json.decode(str));

String allStatuesToJson(AllStatues data) => json.encode(data.toJson());

class AllStatues {
  List<StatusModal>? statuses;

  AllStatues({
    this.statuses,
  });

  AllStatues copyWith({
    List<StatusModal>? statuses,
  }) =>
      AllStatues(
        statuses: statuses ?? this.statuses,
      );

  factory AllStatues.fromJson(Map<String, dynamic> json) => AllStatues(
        statuses: json["statuses"] == null
            ? []
            : List<StatusModal>.from(
                json["statuses"]!.map((x) => StatusModal.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "statuses": statuses == null
            ? []
            : List<dynamic>.from(statuses!.map((x) => x.toJson())),
      };
}

class StatusModal {
  int? id;
  String? name;
  String? color;
  DateTime? createdAt;
  DateTime? updatedAt;
  int? mailsCount;

  StatusModal({
    this.id,
    this.name,
    this.color,
    this.createdAt,
    this.updatedAt,
    this.mailsCount,
  });

  StatusModal copyWith({
    int? id,
    String? name,
    String? color,
    DateTime? createdAt,
    DateTime? updatedAt,
    int? mailsCount,
  }) =>
      StatusModal(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        mailsCount: mailsCount ?? this.mailsCount,
      );

  factory StatusModal.fromJson(Map<String, dynamic> json) => StatusModal(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        mailsCount: json["mails_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "mails_count": mailsCount,
      };
}
