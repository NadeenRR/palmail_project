// To parse this JSON data, do
//
//     final mailSenderlResponse = mailSenderlResponseFromJson(jsonString);

import 'dart:convert';

MailSenderlResponse mailSenderlResponseFromJson(String str) =>
    MailSenderlResponse.fromJson(json.decode(str));

String mailSenderlResponseToJson(MailSenderlResponse data) =>
    json.encode(data.toJson());

class MailSenderlResponse {
  MailSenderlResponseSender? sender;

  MailSenderlResponse({
    this.sender,
  });

  MailSenderlResponse copyWith({
    MailSenderlResponseSender? sender,
  }) =>
      MailSenderlResponse(
        sender: sender ?? this.sender,
      );

  factory MailSenderlResponse.fromJson(Map<String, dynamic> json) =>
      MailSenderlResponse(
        sender: json["sender"] == null
            ? null
            : MailSenderlResponseSender.fromJson(json["sender"]),
      );

  Map<String, dynamic> toJson() => {
        "sender": sender?.toJson(),
      };
}

class MailSenderlResponseSender {
  int? id;
  String? name;
  String? mobile;
  String? address;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  int? mailsCount;
  PurpleCategory? category;
  List<Mail>? mails;

  MailSenderlResponseSender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.mailsCount,
    this.category,
    this.mails,
  });

  MailSenderlResponseSender copyWith({
    int? id,
    String? name,
    String? mobile,
    String? address,
    int? categoryId,
    String? createdAt,
    String? updatedAt,
    int? mailsCount,
    PurpleCategory? category,
    List<Mail>? mails,
  }) =>
      MailSenderlResponseSender(
        id: id ?? this.id,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        address: address ?? this.address,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        mailsCount: mailsCount ?? this.mailsCount,
        category: category ?? this.category,
        mails: mails ?? this.mails,
      );

  factory MailSenderlResponseSender.fromJson(Map<String, dynamic> json) =>
      MailSenderlResponseSender(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        mailsCount: json["mails_count"],
        category: json["category"] == null
            ? null
            : PurpleCategory.fromJson(json["category"]),
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "mails_count": mailsCount,
        "category": category?.toJson(),
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
      };
}

class PurpleCategory {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  PurpleCategory({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  PurpleCategory copyWith({
    int? id,
    String? name,
    String? createdAt,
    String? updatedAt,
  }) =>
      PurpleCategory(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
      );

  factory PurpleCategory.fromJson(Map<String, dynamic> json) => PurpleCategory(
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

class Mail {
  int? id;
  String? subject;
  dynamic description;
  int? senderId;
  String? archiveNumber;
  String? archiveDate;
  dynamic decision;
  int? statusId;
  dynamic finalDecision;
  String? createdAt;
  String? updatedAt;
  MailSender? sender;
  Status? status;
  List<dynamic>? attachments;
  List<dynamic>? activities;
  List<Tag>? tags;

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

  Mail copyWith(
          {int? id,
          String? subject,
          dynamic description,
          int? senderId,
          String? archiveNumber,
          String? archiveDate,
          dynamic decision,
          int? statusId,
          dynamic finalDecision,
          String? createdAt,
          String? updatedAt,
          MailSender? sender,
          Status? status,
          List<Attachment>? attachments,
          List<Activity>? activities,
          List<Tag>? tags}) =>
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
        activities: activities ?? activities,
        tags: tags ?? tags,
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
        sender:
            json["sender"] == null ? null : MailSender.fromJson(json["sender"]),
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        attachments: json["attachments"] == null
            ? []
            : List<Attachment>.from(
                json["attachments"]!.map((x) => Attachment.fromJson(x))),
        activities: json["activities"] == null
            ? []
            : List<Activity>.from(
                json["activities"]!.map((x) => Activity.fromJson(x))),
        tags: json["tags"] == null
            ? []
            : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
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
        "sender": sender?.toJson(),
        "status": status?.toJson(),
        "attachments": attachments == null
            ? []
            : List<dynamic>.from(attachments!.map((x) => x.toJson())),
        "activities": activities == null
            ? []
            : List<dynamic>.from(activities!.map((x) => x.toJson())),
        "tags": tags == null
            ? []
            : List<dynamic>.from(tags!.map((x) => x.toJson())),
      };
}

class MailSender {
  int? id;
  String? name;
  String? mobile;
  String? address;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  FluffyCategory? category;

  MailSender({
    this.id,
    this.name,
    this.mobile,
    this.address,
    this.categoryId,
    this.createdAt,
    this.updatedAt,
    this.category,
  });

  MailSender copyWith({
    int? id,
    String? name,
    String? mobile,
    String? address,
    int? categoryId,
    String? createdAt,
    String? updatedAt,
    FluffyCategory? category,
  }) =>
      MailSender(
        id: id ?? this.id,
        name: name ?? this.name,
        mobile: mobile ?? this.mobile,
        address: address ?? this.address,
        categoryId: categoryId ?? this.categoryId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        category: category ?? this.category,
      );

  factory MailSender.fromJson(Map<String, dynamic> json) => MailSender(
        id: json["id"],
        name: json["name"],
        mobile: json["mobile"],
        address: json["address"],
        categoryId: json["category_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
        category: json["category"] == null
            ? null
            : FluffyCategory.fromJson(json["category"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "mobile": mobile,
        "address": address,
        "category_id": categoryId,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "category": category?.toJson(),
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
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

class Attachment {
  int? id;
  String? title;
  String? image;
  int? mailId;
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

class User {
  int? id;
  String? name;
  String? email;
  String? image;
  String? emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;

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

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        image: json["image"],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
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
      };
}

class FluffyCategory {
  int? id;
  String? name;

  FluffyCategory({
    this.id,
    this.name,
  });

  FluffyCategory copyWith({
    int? id,
    String? name,
  }) =>
      FluffyCategory(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory FluffyCategory.fromJson(Map<String, dynamic> json) => FluffyCategory(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class Status {
  int? id;
  String? name;
  String? color;

  Status({
    this.id,
    this.name,
    this.color,
  });

  Status copyWith({
    int? id,
    String? name,
    String? color,
  }) =>
      Status(
        id: id ?? this.id,
        name: name ?? this.name,
        color: color ?? this.color,
      );

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        id: json["id"],
        name: json["name"],
        color: json["color"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "color": color,
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

class Pivot {
  int? mailId;
  int? tagId;

  Pivot({
    this.mailId,
    this.tagId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        mailId: json["mail_id"],
        tagId: json["tag_id"],
      );

  Map<String, dynamic> toJson() => {
        "mail_id": mailId,
        "tag_id": tagId,
      };
}
