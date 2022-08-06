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
  });

  bool? status;
  Music? music;
  List<Music>? affirmations;
  List<Recording>? recordings;

  factory SingleMusic.fromJson(Map<String, dynamic> json) => SingleMusic(
        status: json["status"],
        music: Music.fromJson(json["music"]),
        affirmations: List<Music>.from(
            json["affirmations"].map((x) => Music.fromJson(x))),
        recordings: List<Recording>.from(
            json["recordings"].map((x) => Recording.fromJson(x))),
      );
}
