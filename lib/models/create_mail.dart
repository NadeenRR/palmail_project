// To parse this JSON data, do
//
//     final createMail = createMailFromJson(jsonString);

import 'dart:convert';

CreateMail createMailFromJson(String str) =>
    CreateMail.fromJson(json.decode(str));

String createMailToJson(CreateMail data) => json.encode(data.toJson());

class CreateMail {
  String? message;
  Mail? mail;

  CreateMail({
    this.message,
    this.mail,
  });

  CreateMail copyWith({
    String? message,
    Mail? mail,
  }) =>
      CreateMail(
        message: message ?? this.message,
        mail: mail ?? this.mail,
      );

  factory CreateMail.fromJson(Map<String, dynamic> json) => CreateMail(
        message: json["message"],
        mail: json["mail"] == null ? null : Mail.fromJson(json["mail"]),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "mail": mail?.toJson(),
      };
}

class Mail {
  int? id;
  String? subject;
  String? description;
  int? senderId;
  String? archiveNumber;
  DateTime? archiveDate;
  String? decision;
  int? statusId;
  String? finalDecision;
  DateTime? createdAt;
  DateTime? updatedAt;
  Sender? sender;
  Status? status;
  List<dynamic>? attachments;
  List<Activity>? activities;
  List<Status>? tags;

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
    this.sender,
    this.status,
    this.attachments,
    this.activities,
    this.tags,
  });

  Mail copyWith({
    int? id,
    String? subject,
    String? description,
    int? senderId,
    String? archiveNumber,
    DateTime? archiveDate,
    String? decision,
    int? statusId,
    String? finalDecision,
    DateTime? createdAt,
    DateTime? updatedAt,
    Sender? sender,
    Status? status,
    List<dynamic>? attachments,
    List<Activity>? activities,
    List<Status>? tags,
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
        sender: sender ?? this.sender,
        status: status ?? this.status,
        attachments: attachments ?? this.attachments,
        activities: activities ?? this.activities,
        tags: tags ?? this.tags,
      );

  factory Mail.fromJson(Map<String, dynamic> json) => Mail(
        id: json["id"],
        subject: json["subject"],
        description: json["description"],
        senderId: json["sender_id"],
        archiveNumber: json["archive_number"],
        archiveDate: json["archive_date"] == null
            ? null
            : DateTime.parse(json["archive_date"]),
        decision: json["decision"],
        statusId: json["status_id"],
        finalDecision: json["final_decision"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        attachments: json["attachments"] == null
            ? []
            : List<dynamic>.from(json["attachments"]!.map((x) => x)),
        activities: json["activities"] == null
            ? []
            : List<Activity>.from(
                json["activities"]!.map((x) => Activity.fromJson(x))),
        tags: json["tags"] == null
            ? []
            : List<Status>.from(json["tags"]!.map((x) => Status.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "subject": subject,
        "description": description,
        "sender_id": senderId,
        "archive_number": archiveNumber,
        "archive_date": archiveDate?.toIso8601String(),
        "decision": decision,
        "status_id": statusId,
        "final_decision": finalDecision,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "sender": sender?.toJson(),
        "status": status?.toJson(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x)),
        "activities": activities == null
            ? []
            : List<dynamic>.from(activities!.map((x) => x.toJson())),
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}

class Activity {
  int? id;
  String? body;
  int? userId;
  int? mailId;
  dynamic sendNumber;
  dynamic sendDate;
  dynamic sendDestination;
  DateTime? createdAt;
  DateTime? updatedAt;

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
  });

  Activity copyWith({
    int? id,
    String? body,
    int? userId,
    int? mailId,
    dynamic sendNumber,
    dynamic sendDate,
    dynamic sendDestination,
    DateTime? createdAt,
    DateTime? updatedAt,
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
      );

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
        id: json["id"],
        body: json["body"],
        userId: json["user_id"],
        mailId: json["mail_id"],
        sendNumber: json["send_number"],
        sendDate: json["send_date"],
        sendDestination: json["send_destination"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": body,
        "user_id": userId,
        "mail_id": mailId,
        "send_number": sendNumber,
        "send_date": sendDate,
        "send_destination": sendDestination,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
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
  Status? category;

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

  Sender copyWith({
    int? id,
    String? name,
    String? mobile,
    dynamic address,
    int? categoryId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Status? category,
  }) =>
      Sender(
        id: id ?? this.id,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        address: address ?? this.address,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
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
        category:
            json["category"] == null ? null : Status.fromJson(json["category"]),
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

class Status {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? color;
  Pivot? pivot;

  Status({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.color,
    this.pivot,
  });

  Status copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? color,
    Pivot? pivot,
  }) =>
      Status(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        color: color ?? this.color,
        pivot: pivot ?? this.pivot,
      );

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        color: json["color"],
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "color": color,
        "pivot": pivot?.toJson(),
      };
}

class Pivot {
  int? mailId;
  int? tagId;

  Pivot({
    this.mailId,
    this.tagId,
  });

  Pivot copyWith({
    int? mailId,
    int? tagId,
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
