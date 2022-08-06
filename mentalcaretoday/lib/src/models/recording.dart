// To parse this JSON data, do
//
//     final myRecording = myRecordingFromJson(jsonString);

import 'dart:convert';

import 'package:mentalcaretoday/src/models/single_mood.dart';

MyRecording myRecordingFromJson(String str) =>
    MyRecording.fromJson(json.decode(str));

class MyRecording {
  MyRecording({
    required this.status,
    required this.recordings,
  });

  bool status;
  List<Recording> recordings;

  factory MyRecording.fromJson(Map<String, dynamic> json) => MyRecording(
        status: json["status"],
        recordings: List<Recording>.from(
            json["recordings"].map((x) => Recording.fromJson(x))),
      );
}
