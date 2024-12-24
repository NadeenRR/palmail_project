// To parse this JSON data, do
//
//     final uploadAttachment = uploadAttachmentFromJson(jsonString);

import 'dart:convert';

UploadAttachment uploadAttachmentFromJson(String str) =>
    UploadAttachment.fromJson(json.decode(str));

String uploadAttachmentToJson(UploadAttachment data) =>
    json.encode(data.toJson());

class UploadAttachment {
  String? message;
  Attachment? attachment;

  UploadAttachment({
    this.message,
    this.attachment,
  });

  UploadAttachment copyWith({
    String? message,
    Attachment? attachment,
  }) =>
      UploadAttachment(
        message: message ?? this.message,
        attachment: attachment ?? this.attachment,
      );

  factory UploadAttachment.fromJson(Map<String, dynamic> json) =>
      UploadAttachment(
        message: json["message"],
        attachment: json["attachment"] == null
            ? null
            : Attachment.fromJson(json["attachment"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "attachment": attachment?.toJson(),
      };
}

class Attachment {
  String? title;
  String? image;
  String? mailId;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Attachment({
    this.title,
    this.image,
    this.mailId,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  Attachment copyWith({
    String? title,
    String? image,
    String? mailId,
    DateTime? updatedAt,
    DateTime? createdAt,
    int? id,
  }) =>
      Attachment(
        title: title ?? this.title,
        image: image ?? this.image,
        mailId: mailId ?? this.mailId,
        updatedAt: updatedAt ?? this.updatedAt,
        createdAt: createdAt ?? this.createdAt,
        id: id ?? this.id,
      );

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        title: json["title"],
        image: json["image"],
        mailId: json["mail_id"],
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        id: json["id"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "image": image,
        "mail_id": mailId,
        "updated_at": updatedAt?.toIso8601String(),
        "created_at": createdAt?.toIso8601String(),
        "id": id,
      };
}
//
