// To parse this JSON data, do
//
//     final mailResponse = mailResponseFromJson(jsonString);

import 'dart:convert';

import 'package:palmail_project/models/user_info.dart';


MailResponse mailResponseFromJson(String str) =>
    MailResponse.fromJson(json.decode(str));

String mailResponseToJson(MailResponse data) => json.encode(data.toJson());

class MailResponse {
  List<Mail>? mails;

  MailResponse({
    this.mails,
  });

  MailResponse copyWith({
    List<Mail>? mail,
  }) =>
      MailResponse(
        mails: mail ?? this.mails,
      );

  // factory MailResponse.fromJson(Map<String, dynamic> json) => MailResponse(
  //       mails: json["mail"] == null
  //           ? []
  //           : List<Mail>.from(json["mail"]!.map((x) => Mail.fromJson(x))),
  //     );
  factory MailResponse.fromJson(Map<String, dynamic> json) => MailResponse(
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"].map((x) => Mail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
      };
}

class Mail {
  int? id;
  String? subject;
  dynamic description;
  String? senderId;
  String? archiveNumber;
  String? archiveDate;
  String? decision;
  String? statusId;
  dynamic finalDecision;
  String? createdAt;
  String? updatedAt;
  String? activitiesCount;
  Sender? sender;
  dynamic status;
  List<Tag>? tags;
  List<Attachment>? attachments;
  List<Activity>? activities;

  Mail({
    this.id,
    this.subject,
    this.description,
    this.senderId,
    this.archiveNumber,
    this.archiveDate,
    this.decision,
    this.statusId,
    this.finalDecision,
    this.createdAt,
    this.updatedAt,
    this.activitiesCount,
    this.sender,
    this.status,
    this.tags,
    this.attachments,
    this.activities,
  });

  Mail copyWith({
    int? id,
    String? subject,
    dynamic description,
    String? senderId,
    String? archiveNumber,
    String? archiveDate,
    String? decision,
    String? statusId,
    dynamic finalDecision,
    String? createdAt,
    String? updatedAt,
    String? activitiesCount,
    Sender? sender,
    dynamic status,
    List<Tag>? tags,
    List<Attachment>? attachments,
    List<Activity>? activities,
  }) =>
      Mail(
        id: id ?? this.id,
        subject: subject ?? this.subject,
        description: description ?? this.description,
        senderId: senderId ?? this.senderId,
        archiveNumber: archiveNumber ?? this.archiveNumber,
        archiveDate: archiveDate ?? this.archiveDate,
        decision: decision ?? this.decision,
        statusId: statusId ?? this.statusId,
        finalDecision: finalDecision ?? this.finalDecision,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        activitiesCount: activitiesCount ?? this.activitiesCount,
        sender: sender ?? this.sender,
        status: status ?? this.status,
        tags: tags ?? this.tags,
        attachments: attachments ?? this.attachments,
        activities: activities ?? this.activities,
      );

  factory Mail.fromJson(Map<String, dynamic> json) => Mail(
        id: json["id"],
        subject: json["subject"],
        description: json["description"],
        senderId: json["sender_id"],
        archiveNumber: json["archive_number"],
        archiveDate: json["archive_date"],
        decision: json["decision"],
        statusId: json["status_id"],
        finalDecision: json["final_decision"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        activitiesCount: json["activities_count"],
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        status: json["status"],
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(// Updated to List<Attachment>
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        activities: json["activities"] == null
            ? []
            : List<Activity>.from(
                json["activities"]!.map((x) => Activity.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "description": description,
        "sender_id": senderId,
        "archive_number": archiveNumber,
        "archive_date": archiveDate,
        "decision": decision,
        "status_id": statusId,
        "final_decision": finalDecision,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "activities_count": activitiesCount,
        "sender": sender?.toJson(),
        "status": status,
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!
                .map((x) => x.toJson())), // Updated to List<Attachment>
        "activities": activities == null
            ? []
            : List<dynamic>.from(activities!.map((x) => x.toJson())),
      };
}

class Activity {
  int? id;
  String? body;
  String? userId;
  String? mailId;
  dynamic sendNumber;
  dynamic sendDate;
  dynamic sendDestination;
  String? createdAt;
  String? updatedAt;
  User? user;

  Activity({
    this.id,
    this.body,
    this.userId,
    this.mailId,
    this.sendNumber,
    this.sendDate,
    this.sendDestination,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  Activity copyWith({
    int? id,
    String? body,
    String? userId,
    String? mailId,
    dynamic sendNumber,
    dynamic sendDate,
    dynamic sendDestination,
    String? createdAt,
    String? updatedAt,
    User? user,
  }) =>
      Activity(
        id: id ?? this.id,
        body: body ?? this.body,
        userId: userId ?? this.userId,
        mailId: mailId ?? this.mailId,
        sendNumber: sendNumber ?? this.sendNumber,
        sendDate: sendDate ?? this.sendDate,
        sendDestination: sendDestination ?? this.sendDestination,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        user: user ?? this.user,
      );

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        body: json["body"],
        userId: json["user_id"],
        mailId: json["mail_id"],
        sendNumber: json["send_number"],
        sendDate: json["send_date"],
        sendDestination: json["send_destination"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        user: json["user"] != null ? User.fromJson(json["user"]) : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "user_id": userId,
        "mail_id": mailId,
        "send_number": sendNumber,
        "send_date": sendDate,
        "send_destination": sendDestination,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "user": user?.toJson(),
      };
}

class Sender {
  int? id;
  String? name;
  String? categoryId;
  Category? category;

  Sender({
    this.id,
    this.name,
    this.categoryId,
    this.category,
  });

  Sender copyWith({
    int? id,
    String? name,
    String? categoryId,
    Category? category,
  }) =>
      Sender(
        id: id ?? this.id,
        name: name ?? this.name,
        categoryId: categoryId ?? this.categoryId,
        category: category ?? this.category,
      );

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        id: json["id"],
        name: json["name"],
        categoryId: json["category_id"],
        category: json["category"] != null
            ? Category.fromJson(json["category"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category_id": categoryId,
        "category": category?.toJson(),
      };
}

class Tag {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;
  Pivot? pivot;

  Tag({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.pivot,
  });

  Tag copyWith({
    int? id,
    String? name,
    String? createdAt,
    String? updatedAt,
    Pivot? pivot,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        pivot: pivot ?? this.pivot,
      );

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "pivot": pivot?.toJson(),
      };
}

class Category {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Category({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
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

class Attachment {
  int? id;
  String? title;
  String? image;
  String? mailId;
  String? createdAt;
  String? updatedAt;

  Attachment({
    this.id,
    this.title,
    this.image,
    this.mailId,
    this.createdAt,
    this.updatedAt,
  });

  Attachment copyWith({
    int? id,
    String? title,
    String? image,
    String? mailId,
    String? createdAt,
    String? updatedAt,
  }) =>
      Attachment(
        id: id ?? this.id,
        title: title ?? this.title,
        image: image ?? this.image,
        mailId: mailId ?? this.mailId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
        id: json["id"],
        title: json["title"],
        image: json["image"],
        mailId: json["mail_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "mail_id": mailId,
        "created_at": createdAt,
        "updated_at": updatedAt,
      };
}

class Pivot {
  String? mailId;
  String? tagId;

  Pivot({
    this.mailId,
    this.tagId,
  });

  Pivot copyWith({
    String? mailId,
    String? tagId,
  }) =>
      Pivot(
        mailId: mailId ?? this.mailId,
        tagId: tagId ?? this.tagId,
      );

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        mailId: json["mail_id"],
        tagId: json["tag_id"],
      );

  Map<String, dynamic> toJson() => {
        "mail_id": mailId,
        "tag_id": tagId,
      };
}
//
