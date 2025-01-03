// // To parse this JSON data, do
// //
// //     final singleMailResponse = singleMailResponseFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:gsg_final_project/models/user_info.dart';
//
import 'dart:convert';

SingleMailResponse singleMailResponseFromJson(String str) =>
    SingleMailResponse.fromJson(json.decode(str));

// String singleMailResponseToJson(SingleMailResponse data) =>
//     json.encode(data.toJson());
//
// class SingleMailResponse {
//   List<Mail>? mail;
//
//   SingleMailResponse({
//     this.mail,
//   });
//
//   SingleMailResponse copyWith({
//     List<Mail>? mail,
//   }) =>
//       SingleMailResponse(
//         mail: mail ?? this.mail,
//       );
//
//   factory SingleMailResponse.fromJson(Map<String, dynamic> json) =>
//       SingleMailResponse(
//         mail: json["mail"] == null
//             ? []
//             : List<Mail>.from(json["mail"]!.map((x) => Mail.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "mail": mail == null
//             ? []
//             : List<dynamic>.from(mail!.map((x) => x.toJson())),
//       };
// }
//
// class Mail {
//   int? id;
//   String? subject;
//   String? description;
//   String? senderId;
//   String? archiveNumber;
//   String? archiveDate;
//   String? decision;
//   String? statusId;
//   String? finalDecision;
//   String? createdAt;
//   String? updatedAt;
//   String? activitiesCount;
//   Sender? sender;
//   Status? status;
//   List<Attachment>? attachments;
//   List<Activity>? activities;
//   List<Tag>? tags;
//
//   Mail({
//     this.id,
//     this.subject,
//     this.description,
//     this.senderId,
//     this.archiveNumber,
//     this.archiveDate,
//     this.decision,
//     this.statusId,
//     this.finalDecision,
//     this.createdAt,
//     this.updatedAt,
//     this.activitiesCount,
//     this.sender,
//     this.status,
//     this.attachments,
//     this.activities,
//     this.tags,
//   });
//
//   Mail copyWith({
//     int? id,
//     String? subject,
//     String? description,
//     String? senderId,
//     String? archiveNumber,
//     String? archiveDate,
//     String? decision,
//     String? statusId,
//     String? finalDecision,
//     String? createdAt,
//     String? updatedAt,
//     String? activitiesCount,
//     Sender? sender,
//     Status? status,
//     List<Attachment>? attachments,
//     List<Activity>? activities,
//     List<Tag>? tags,
//   }) =>
//       Mail(
//         id: id ?? this.id,
//         subject: subject ?? this.subject,
//         description: description ?? this.description,
//         senderId: senderId ?? this.senderId,
//         archiveNumber: archiveNumber ?? this.archiveNumber,
//         archiveDate: archiveDate ?? this.archiveDate,
//         decision: decision ?? this.decision,
//         statusId: statusId ?? this.statusId,
//         finalDecision: finalDecision ?? this.finalDecision,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         activitiesCount: activitiesCount ?? this.activitiesCount,
//         sender: sender ?? this.sender,
//         status: status ?? this.status,
//         attachments: attachments ?? this.attachments,
//         activities: activities ?? this.activities,
//         tags: tags ?? this.tags,
//       );
//
//   factory Mail.fromJson(Map<String, dynamic> json) => Mail(
//         id: json["id"],
//         subject: json["subject"],
//         description: json["description"],
//         senderId: json["sender_id"],
//         archiveNumber: json["archive_number"],
//         archiveDate: json["archive_date"],
//         decision: json["decision"],
//         statusId: json["status_id"],
//         finalDecision: json["final_decision"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         activitiesCount: json["activities_count"],
//         sender: json["sender"] == null ? null : Sender.fromJson(json["sender"]),
//         status: json["status"] == null ? null : Status.fromJson(json["status"]),
//         attachments: json["attachments"] == null
//             ? []
//             : List<Attachment>.from(
//                 json["attachments"]!.map((x) => Attachment.fromJson(x))),
//         activities: json["activities"] == null
//             ? []
//             : List<Activity>.from(
//                 json["activities"]!.map((x) => Activity.fromJson(x))),
//         tags: json["tags"] == null
//             ? []
//             : List<Tag>.from(json["tags"]!.map((x) => Tag.fromJson(x))),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "subject": subject,
//         "description": description,
//         "sender_id": senderId,
//         "archive_number": archiveNumber,
//         "archive_date": archiveDate,
//         "decision": decision,
//         "status_id": statusId,
//         "final_decision": finalDecision,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "activities_count": activitiesCount,
//         "sender": sender?.toJson(),
//         "status": status?.toJson(),
//         "attachments": attachments == null
//             ? []
//             : List<dynamic>.from(attachments!.map((x) => x.toJson())),
//         "activities": activities == null
//             ? []
//             : List<dynamic>.from(activities!.map((x) => x.toJson())),
//         "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
//       };
// }
//
// class Activity {
//   int? id;
//   String? body;
//   String? userId;
//   String? mailId;
//   dynamic sendNumber;
//   dynamic sendDate;
//   dynamic sendDestination;
//   String? createdAt;
//   String? updatedAt;
// User? user;

//
//   Activity({
//     this.id,
//     this.body,
//     this.userId,
//     this.mailId,
//     this.sendNumber,
//     this.sendDate,
//     this.sendDestination,
//     this.createdAt,
//     this.updatedAt,
//     this.user,
//   });
//
//   Activity copyWith({
//     int? id,
//     String? body,
//     String? userId,
//     String? mailId,
//     dynamic sendNumber,
//     dynamic sendDate,
//     dynamic sendDestination,
//     String? createdAt,
//     String? updatedAt,
//     User? user,
//   }) =>
//       Activity(
//         id: id ?? this.id,
//         body: body ?? this.body,
//         userId: userId ?? this.userId,
//         mailId: mailId ?? this.mailId,
//         sendNumber: sendNumber ?? this.sendNumber,
//         sendDate: sendDate ?? this.sendDate,
//         sendDestination: sendDestination ?? this.sendDestination,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         user: user ?? this.user,
//       );
//
//   factory Activity.fromJson(Map<String, dynamic> json) => Activity(
//         id: json["id"],
//         body: json["body"],
//         userId: json["user_id"],
//         mailId: json["mail_id"],
//         sendNumber: json["send_number"],
//         sendDate: json["send_date"],
//         sendDestination: json["send_destination"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         user: json["user"] != null ? User.fromJson(json["user"]) : null,
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "body": body,
//         "user_id": userId,
//         "mail_id": mailId,
//         "send_number": sendNumber,
//         "send_date": sendDate,
//         "send_destination": sendDestination,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "user": user?.toJson(),
//       };
// }
//
// class Attachment {
//   int? id;
//   String? title;
//   String? image;
//   String? mailId;
//   String? createdAt;
//   String? updatedAt;
//
//   Attachment({
//     this.id,
//     this.title,
//     this.image,
//     this.mailId,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   Attachment copyWith({
//     int? id,
//     String? title,
//     String? image,
//     String? mailId,
//     String? createdAt,
//     String? updatedAt,
//   }) =>
//       Attachment(
//         id: id ?? this.id,
//         title: title ?? this.title,
//         image: image ?? this.image,
//         mailId: mailId ?? this.mailId,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );
//
//   factory Attachment.fromJson(Map<String, dynamic> json) => Attachment(
//         id: json["id"],
//         title: json["title"],
//         image: json["image"],
//         mailId: json["mail_id"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "title": title,
//         "image": image,
//         "mail_id": mailId,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }
//
// class Sender {
//   int? id;
//   String? name;
//   String? categoryId;
//   Category? category;
//
//   Sender({
//     this.id,
//     this.name,
//     this.categoryId,
//     this.category,
//   });
//
//   Sender copyWith({
//     int? id,
//     String? name,
//     String? categoryId,
//     Category? category,
//   }) =>
//       Sender(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         categoryId: categoryId ?? this.categoryId,
//         category: category ?? this.category,
//       );
//
//   factory Sender.fromJson(Map<String, dynamic> json) => Sender(
//         id: json["id"],
//         name: json["name"],
//         categoryId: json["category_id"],
//         category: json["category"] == null
//             ? null
//             : Category.fromJson(json["category"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "category_id": categoryId,
//         "category": category?.toJson(),
//       };
// }
//
// class Category {
//   int? id;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//
//   Category({
//     this.id,
//     this.name,
//     this.createdAt,
//     this.updatedAt,
//   });
//
//   Category copyWith({
//     int? id,
//     String? name,
//     String? createdAt,
//     String? updatedAt,
//   }) =>
//       Category(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//       );
//
//   factory Category.fromJson(Map<String, dynamic> json) => Category(
//         id: json["id"],
//         name: json["name"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//       };
// }
//
// class Tag {
//   int? id;
//   String? name;
//   String? createdAt;
//   String? updatedAt;
//   Pivot? pivot;
//
//   Tag({
//     this.id,
//     this.name,
//     this.createdAt,
//     this.updatedAt,
//     this.pivot,
//   });
//
//   Tag copyWith({
//     int? id,
//     String? name,
//     String? createdAt,
//     String? updatedAt,
//     Pivot? pivot,
//   }) =>
//       Tag(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         createdAt: createdAt ?? this.createdAt,
//         updatedAt: updatedAt ?? this.updatedAt,
//         pivot: pivot ?? this.pivot,
//       );
//
//   factory Tag.fromJson(Map<String, dynamic> json) => Tag(
//         id: json["id"],
//         name: json["name"],
//         createdAt: json["created_at"],
//         updatedAt: json["updated_at"],
//         pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "created_at": createdAt,
//         "updated_at": updatedAt,
//         "pivot": pivot?.toJson(),
//       };
// }
//
// class Pivot {
//   String? mailId;
//   String? tagId;
//
//   Pivot({
//     this.mailId,
//     this.tagId,
//   });
//
//   Pivot copyWith({
//     String? mailId,
//     String? tagId,
//   }) =>
//       Pivot(
//         mailId: mailId ?? this.mailId,
//         tagId: tagId ?? this.tagId,
//       );
//
//   factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
//         mailId: json["mail_id"],
//         tagId: json["tag_id"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "mail_id": mailId,
//         "tag_id": tagId,
//       };
// }
//
// class Status {
//   int? id;
//   String? name;
//   String? color;
//
//   Status({
//     this.id,
//     this.name,
//     this.color,
//   });
//
//   Status copyWith({
//     int? id,
//     String? name,
//     String? color,
//   }) =>
//       Status(
//         id: id ?? this.id,
//         name: name ?? this.name,
//         color: color ?? this.color,
//       );
//
//   factory Status.fromJson(Map<String, dynamic> json) => Status(
//         id: json["id"],
//         name: json["name"],
//         color: json["color"],
//       );
//
//   Map<String, dynamic> toJson() => {
//         "id": id,
//         "name": name,
//         "color": color,
//       };
// }
class SingleMailResponse {
  Mail? mail;

  SingleMailResponse({this.mail});

  factory SingleMailResponse.fromJson(Map<String, dynamic> json) {
    return SingleMailResponse(
      mail: json['mail'] != null ? Mail.fromJson(json['mail'][0]) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mail': mail?.toJson(),
    };
  }
}

class Mail {
  int? id;
  String? subject;
  String? description;
  int? senderId;
  String? archiveNumber;
  String? archiveDate;
  String? decision;
  int? statusId;
  String? finalDecision;
  String? createdAt;
  String? updatedAt;
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
    this.sender,
    this.status,
    this.attachments,
    this.activities,
    this.tags,
  });

  factory Mail.fromJson(Map<String, dynamic> json) {
    return Mail(
      id: json['id'],
      subject: json['subject'],
      description: json['description'],
      senderId: json['sender_id'],
      archiveNumber: json['archive_number'],
      archiveDate: json['archive_date'],
      decision: json['decision'],
      statusId: json['status_id'],
      finalDecision: json['final_decision'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      sender: json['sender'] != null ? Sender.fromJson(json['sender']) : null,
      status: json['status'] != null ? Status.fromJson(json['status']) : null,
      attachments: List<Attachment>.from(
          json['attachments'].map((x) => Attachment.fromJson(x))),
      activities: List<Activity>.from(
          json['activities'].map((x) => Activity.fromJson(x))),
      tags: List<Tag>.from(json['tags'].map((x) => Tag.fromJson(x))),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'subject': subject,
      'description': description,
      'sender_id': senderId,
      'archive_number': archiveNumber,
      'archive_date': archiveDate,
      'decision': decision,
      'status_id': statusId,
      'final_decision': finalDecision,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'sender': sender?.toJson(),
      'status': status?.toJson(),
      'attachments':
          attachments?.map((attachment) => attachment.toJson()).toList(),
      'activities': activities?.map((activity) => activity.toJson()).toList(),
      'tags': tags?.map((tag) => tag.toJson()).toList(),
    };
  }
}

class Sender {
  int? id;
  String? name;
  String? mobile;
  String? address;
  int? categoryId;
  String? createdAt;
  String? updatedAt;
  Category? category;

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

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      address: json['address'],
      categoryId: json['category_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      category:
          json['category'] != null ? Category.fromJson(json['category']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'address': address,
      'category_id': categoryId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'category': category?.toJson(),
    };
  }
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

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Status {
  int? id;
  String? name;
  String? color;
  String? createdAt;
  String? updatedAt;

  Status({
    this.id,
    this.name,
    this.color,
    this.createdAt,
    this.updatedAt,
  });

  factory Status.fromJson(Map<String, dynamic> json) {
    return Status(
      id: json['id'],
      name: json['name'],
      color: json['color'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'color': color,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
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

  factory Attachment.fromJson(Map<String, dynamic> json) {
    return Attachment(
      id: json['id'],
      title: json['title'],
      image: json['image'],
      mailId: json['mail_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'image': image,
      'mail_id': mailId,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}

class Activity {
  int? id;
  String? body;
  int? userId;
  int? mailId;
  String? sendNumber;
  String? sendDate;
  String? sendDestination;
  String? createdAt;
  String? updatedAt;
  UserMail? user;

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

  factory Activity.fromJson(Map<String, dynamic> json) {
    return Activity(
      id: json['id'],
      body: json['body'],
      userId: json['user_id'],
      mailId: json['mail_id'],
      sendNumber: json['send_number'],
      sendDate: json['send_date'],
      sendDestination: json['send_destination'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'] != null ? UserMail.fromJson(json['user']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'body': body,
      'user_id': userId,
      'mail_id': mailId,
      'send_number': sendNumber,
      'send_date': sendDate,
      'send_destination': sendDestination,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user?.toJson(),
    };
  }
}

class UserMail {
  int? id;
  String? name;
  String? email;
  String? image;
  String? emailVerifiedAt;
  int? roleId;
  String? createdAt;
  String? updatedAt;
  Role? role;

  UserMail({
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

  factory UserMail.fromJson(Map<String, dynamic> json) {
    return UserMail(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      image: json['image'],
      emailVerifiedAt: json['email_verified_at'],
      roleId: json['role_id'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      role: json['role'] != null ? Role.fromJson(json['role']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'image': image,
      'email_verified_at': emailVerifiedAt,
      'role_id': roleId,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'role': role?.toJson(),
    };
  }
}

class Role {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  Role({
    this.id,
    this.name,
    this.createdAt,
    this.updatedAt,
  });

  factory Role.fromJson(Map<String, dynamic> json) {
    return Role(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
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

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      pivot: json['pivot'] != null ? Pivot.fromJson(json['pivot']) : null,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'pivot': pivot?.toJson(),
    };
  }
}

class Pivot {
  int? mailId;
  int? tagId;

  Pivot({
    this.mailId,
    this.tagId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) {
    return Pivot(
      mailId: json['mail_id'],
      tagId: json['tag_id'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'mail_id': mailId,
      'tag_id': tagId,
    };
  }
}
//
