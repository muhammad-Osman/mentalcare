// To parse this JSON data, do
//
//     final singleMusic = singleMusicFromJson(jsonString);

import 'dart:convert';

import 'package:mentalcaretoday/src/models/single_mood.dart';

SingleMusic singleMusicFromJson(String str) =>
    SingleMusic.fromJson(json.decode(str));

class SingleMusic {
  SingleMusic({
    this.status,
    this.music,
    this.affirmations,
    this.recordings,
    this.frequencies,
  });

  bool? status;
  Music? music;
  List<Music>? affirmations;
  List<Frequency>? frequencies;
  List<Recording>? recordings;

  factory SingleMusic.fromJson(Map<String, dynamic> json) => SingleMusic(
        status: json["status"],
        music: Music.fromJson(json["music"]),
        frequencies: List<Frequency>.from(
            json["frequencies"].map((x) => Frequency.fromJson(x))),
        affirmations: List<Music>.from(
            json["affirmations"].map((x) => Music.fromJson(x))),
        recordings: List<Recording>.from(
            json["recordings"].map((x) => Recording.fromJson(x))),
      );
}

class Frequency {
  Frequency({
    required this.id,
    required this.musicId,
    required this.frequency,
    required this.path,
  });

  int id;
  String musicId;
  String frequency;
  String path;

  factory Frequency.fromJson(Map<String, dynamic> json) => Frequency(
        id: json["id"],
        musicId: json["music_id"],
        frequency: json["frequency"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "music_id": musicId,
        "frequency": frequency,
        "path": path,
      };
}
