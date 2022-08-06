// To parse this JSON data, do
//
//     final mood = moodFromJson(jsonString);

import 'dart:convert';

Mood moodFromJson(String str) => Mood.fromJson(json.decode(str));
List<MoodElement> moodsFromJson(String str) => List<MoodElement>.from(
    json.decode(str).map((x) => MoodElement.fromJson(x)));

class Mood {
  Mood({
    this.status,
    this.moods,
  });

  bool? status;
  List<MoodElement>? moods;

  factory Mood.fromJson(Map<String, dynamic> json) => Mood(
        status: json["status"],
        moods: List<MoodElement>.from(
            json["moods"].map((x) => MoodElement.fromJson(x))),
      );
}

class MoodElement {
  MoodElement({
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
  String? createdAt;
  String? updatedAt;

  factory MoodElement.fromJson(Map<String, dynamic> json) => MoodElement(
        id: json["id"],
        name: json["name"],
        color: json["color"],
        deletedAt: json["deleted_at"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
      );
}
