// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

Welcome welcomeFromJson(String str) => Welcome.fromJson(json.decode(str));

String welcomeToJson(Welcome data) => json.encode(data.toJson());

class Welcome {
  Welcome({
    required this.status,
    required this.affirmation,
  });

  bool status;
  Affirmation affirmation;

  factory Welcome.fromJson(Map<String, dynamic> json) => Welcome(
        status: json["status"],
        affirmation: Affirmation.fromJson(json["affirmation"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "affirmation": affirmation.toJson(),
      };
}

class Affirmation {
  Affirmation({
    required this.id,
    required this.musicId,
    required this.title,
    required this.premium,
    required this.affirmationDefault,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.path,
  });

  int id;
  String musicId;
  String title;
  bool premium;
  bool affirmationDefault;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  String path;

  factory Affirmation.fromJson(Map<String, dynamic> json) => Affirmation(
        id: json["id"],
        musicId: json["music_id"],
        title: json["title"],
        premium: json["premium"],
        affirmationDefault: json["default"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "music_id": musicId,
        "title": title,
        "premium": premium,
        "default": affirmationDefault,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "path": path,
      };
}
