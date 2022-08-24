// To parse this JSON data, do
//
//     final singleMood = singleMoodFromJson(jsonString);

import 'dart:convert';

SingleMood singleMoodFromJson(String str) =>
    SingleMood.fromJson(json.decode(str));

class SingleMood {
  SingleMood({
    this.status,
    this.mood,
    this.music,
    this.recordings,
  });

  bool? status;
  Mood? mood;
  List<Music>? music;
  List<Recording>? recordings;

  factory SingleMood.fromJson(Map<String, dynamic> json) => SingleMood(
        status: json["status"],
        mood: Mood.fromJson(json["mood"]),
        music: List<Music>.from(json["music"].map((x) => Music.fromJson(x))),
        recordings: List<Recording>.from(
            json["recordings"].map((x) => Recording.fromJson(x))),
      );
}

class Mood {
  Mood({
    this.id,
    this.name,
    this.color,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? name;
  String? color;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Mood.fromJson(Map<String, dynamic> json) => Mood(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );
}

class Music {
  Music({
    this.id,
    this.moodId,
    this.title,
    this.premium,
    this.musicDefault,
    this.createdAt,
    this.updatedAt,
    this.path,
    this.affirmations,
    this.musicId,
    this.deletedAt,
  });

  int? id;
  String? moodId;
  String? title;
  bool? premium;
  bool? musicDefault;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? path;
  List<Music>? affirmations;
  String? musicId;
  dynamic deletedAt;

  factory Music.fromJson(Map<String, dynamic> json) => Music(
        id: json["id"],
        moodId: json["mood_id"],
        title: json["title"],
        premium: json["premium"],
        musicDefault: json["default"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        path: json["path"],
        affirmations: json["affirmations"] == null
            ? null
            : List<Music>.from(
                json["affirmations"].map((x) => Music.fromJson(x))),
        musicId: json["music_id"],
        deletedAt: json["deleted_at"],
      );
}

class Recording {
  Recording({
    this.id,
    this.userId,
    this.affirmationId,
    this.name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.path,
  });

  int? id;
  String? userId;
  String? affirmationId;
  String? name;
  dynamic deletedAt;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? path;

  factory Recording.fromJson(Map<String, dynamic> json) => Recording(
        id: json["id"],
        userId: json["user_id"],
        affirmationId: json["affirmation_id"],
        name: json["name"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        path: json["path"],
      );
}
