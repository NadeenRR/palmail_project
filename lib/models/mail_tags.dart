// To parse this JSON data, do
//
//     final mailTags = mailTagsFromJson(jsonString);

import 'dart:convert';

MailTags mailTagsFromJson(String str) => MailTags.fromJson(json.decode(str));

String mailTagsToJson(MailTags data) => json.encode(data.toJson());

class MailTags {
  List<Tag>? tags;

  MailTags({
    this.tags,
  });

  MailTags copyWith({
    List<Tag>? tags,
  }) =>
      MailTags(
        tags: tags ?? this.tags,
      );

  factory MailTags.fromJson(Map<String, dynamic> json) => MailTags(
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

class Sender {
  int? id;
  String? name;
  String? mobile;
  dynamic address;
  int? categoryId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Tag? category;

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
    Tag? category,
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
            json["category"] == null ? null : Tag.fromJson(json["category"]),
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

class User {
  int? id;
  Name? name;
  Email? email;
  Image? image;
  dynamic emailVerifiedAt;
  int? roleId;
  DateTime? createdAt;
  DateTime? updatedAt;
  Tag? role;

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

  User copyWith({
    int? id,
    Name? name,
    Email? email,
    Image? image,
    dynamic emailVerifiedAt,
    int? roleId,
    DateTime? createdAt,
    DateTime? updatedAt,
    Tag? role,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        image: image ?? this.image,
        emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
        roleId: roleId ?? this.roleId,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        role: role ?? this.role,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: nameValues.map[json["name"]],
        email: emailValues.map[json["email"]],
        image: imageValues.map[json["image"]],
        emailVerifiedAt: json["email_verified_at"],
        roleId: json["role_id"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        role: json["role"] == null ? null : Tag.fromJson(json["role"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": nameValues.reverse[name],
        "email": emailValues.reverse[email],
        "image": imageValues.reverse[image],
        "email_verified_at": emailVerifiedAt,
        "role_id": roleId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "role": role?.toJson(),
      };
}

class Activity {
  int? id;
  Body? body;
  int? userId;
  int? mailId;
  dynamic sendNumber;
  dynamic sendDate;
  dynamic sendDestination;
  DateTime? createdAt;
  DateTime? updatedAt;
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
    Body? body,
    int? userId,
    int? mailId,
    dynamic sendNumber,
    dynamic sendDate,
    dynamic sendDestination,
    DateTime? createdAt,
    DateTime? updatedAt,
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
        body: bodyValues.map[json["body"]],
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
        user: json["user"] == null ? null : User.fromJson(json["user"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "body": bodyValues.reverse[body],
        "user_id": userId,
        "mail_id": mailId,
        "send_number": sendNumber,
        "send_date": sendDate,
        "send_destination": sendDestination,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "user": user?.toJson(),
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
  Pivot? pivot;
  Sender? sender;
  Status? status;
  List<Attachment>? attachments;
  List<Activity>? activities;
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
    this.pivot,
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
    Pivot? pivot,
    Sender? sender,
    Status? status,
    List<Attachment>? attachments,
    List<Activity>? activities,
    List<Tag>? tags,
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
        pivot: pivot ?? this.pivot,
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
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
        sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
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
        "archive_date": archiveDate?.toIso8601String(),
        "decision": decision,
        "status_id": statusId,
        "final_decision": finalDecision,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": pivot?.toJson(),
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

class Tag {
  int? id;
  String? name;
  DateTime? createdAt;
  DateTime? updatedAt;
  List<Mail>? mails;
  Pivot? pivot;

  Tag({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
    this.mails,
    this.pivot,
  });

  Tag copyWith({
    int? id,
    String? name,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Mail>? mails,
    Pivot? pivot,
  }) =>
      Tag(
        id: id ?? this.id,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        mails: mails ?? this.mails,
        pivot: pivot ?? this.pivot,
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
        mails: json["mails"] == null
            ? []
            : List<Mail>.from(json["mails"]!.map((x) => Mail.fromJson(x))),
        pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "mails": mails == null
            ? []
            : List<dynamic>.from(mails!.map((x) => x.toJson())),
        "pivot": pivot?.toJson(),
      };
}

enum Email { A_A_COM, DANA_GMAIL_COM, ENAS_GMAIL_COM, T_T_COM }

final emailValues = EnumValues({
  "a@a.com": Email.A_A_COM,
  "dana@gmail.com": Email.DANA_GMAIL_COM,
  "enas@gmail.com": Email.ENAS_GMAIL_COM,
  "t@t.com": Email.T_T_COM
});

enum Image {
  PROFILES_KHQ_ED_AX_EX_Q75_RHOVHQ_PPT80_GX4_J_JWSV_HQ_G_FE5_RE_F_PNG,
  PROFILES_P8_QM0_C_NI6_ZVGOU_NX_OO8_K_PPL_XR_O8_Q8_EE_VDLX77_BO_F_PNG,
  PROFILES_T_V8_CCCM_GPB_XGMK_SVB_FO3_OPP_FE_U_NZ_VSIUXX_MQ_PD9_C_JPG,
  PROFILES_ZJ_WNWLM3_PA8_ZQOBJP_EN_WY7_Z2_Q_Y_SGFY1_FJE_Z_WGB7_W_JPG
}

final imageValues = EnumValues({
  "profiles/KhqEdAXExQ75rhovhqPPT80GX4jJWSVHqGFe5reF.png":
      Image.PROFILES_KHQ_ED_AX_EX_Q75_RHOVHQ_PPT80_GX4_J_JWSV_HQ_G_FE5_RE_F_PNG,
  "profiles/p8Qm0cNI6ZVGOUNxOO8kPplXrO8Q8EeVDLX77BoF.png": Image
      .PROFILES_P8_QM0_C_NI6_ZVGOU_NX_OO8_K_PPL_XR_O8_Q8_EE_VDLX77_BO_F_PNG,
  "profiles/tV8CccmGpbXGMKSvbFO3OppFeUNzVsiuxxMqPd9c.jpg":
      Image.PROFILES_T_V8_CCCM_GPB_XGMK_SVB_FO3_OPP_FE_U_NZ_VSIUXX_MQ_PD9_C_JPG,
  "profiles/ZjWNWLM3PA8zqobjpEnWy7Z2qYSgfy1FjeZWgb7W.jpg":
      Image.PROFILES_ZJ_WNWLM3_PA8_ZQOBJP_EN_WY7_Z2_Q_Y_SGFY1_FJE_Z_WGB7_W_JPG
});

enum Name { DANA, ENAS, OSAMA_AHMED, TEAM_ALWHOOSH }

final nameValues = EnumValues({
  "Dana": Name.DANA,
  "enas": Name.ENAS,
  "osama ahmed": Name.OSAMA_AHMED,
  "Team Alwhoosh": Name.TEAM_ALWHOOSH
});

enum Body { ANY_TEXT, EMPTY, OK, STOP_ADDING_NULL_VALUES }

final bodyValues = EnumValues({
  "any text": Body.ANY_TEXT,
  "": Body.EMPTY,
  "ok": Body.OK,
  "stop adding Null values ": Body.STOP_ADDING_NULL_VALUES
});

class Attachment {
  int? id;
  String? title;
  String? image;
  int? mailId;
  DateTime? createdAt;
  DateTime? updatedAt;

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
    int? mailId,
    DateTime? createdAt,
    DateTime? updatedAt,
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": image,
        "mail_id": mailId,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
      };
}

class Pivot {
  int? tagId;
  int? mailId;

  Pivot({
    this.tagId,
    this.mailId,
  });

  Pivot copyWith({
    int? tagId,
    int? mailId,
  }) =>
      Pivot(
        tagId: tagId ?? this.tagId,
        mailId: mailId ?? this.mailId,
      );

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        tagId: json["tag_id"],
        mailId: json["mail_id"],
      );

  Map<String, dynamic> toJson() => {
        "tag_id": tagId,
        "mail_id": mailId,
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
