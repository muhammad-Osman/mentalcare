import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentalcaretoday/src/UI/views/home_screen.dart';
import 'package:mentalcaretoday/src/models/single_music.dart';
import 'package:mentalcaretoday/src/utils/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/mood.dart' as allMood;
import '../models/single_mood.dart';
import '../utils/error_handling.dart';
import '../utils/utils.dart';

class MoodServices {
  // get user Card
  Future<allMood.Mood> getMoods(
    BuildContext context,
  ) async {
    allMood.Mood? getMoods;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse(getAllMoodsUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      // ignore: use_build_context_synchronously

      httpErrorHandle(
        response: userRes,
        context: context,
        onSuccess: () {
          getMoods = allMood.moodFromJson(userRes.body);
        },
      );
    } catch (e) {
      print(e.toString());
      print("Moods Not Found");
      // showSnackBar(context, e.toString());
    }

    return getMoods!;
  }

  Future<SingleMood> getSingleMood(BuildContext context, int id) async {
    SingleMood? getMoods;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      print(token);
      http.Response userRes = await http.get(
        Uri.parse("$getSingleMoodUrl$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      // ignore: use_build_context_synchronously
      print(userRes.body);
      httpErrorHandle(
        response: userRes,
        context: context,
        onSuccess: () {
          getMoods = singleMoodFromJson(userRes.body);
        },
      );
    } catch (e) {
      print(e.toString());
      print("Moods Not Found");
      // showSnackBar(context, e.toString());
    }

    return getMoods!;
  }

  Future<SingleMusic> getSingleMusic(BuildContext context, int id) async {
    SingleMusic? getMoods;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      print(token);
      http.Response userRes = await http.get(
        Uri.parse("$getSingleMusicUrl$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      // ignore: use_build_context_synchronously
      print(userRes.body);
      httpErrorHandle(
        response: userRes,
        context: context,
        onSuccess: () {
          getMoods = singleMusicFromJson(userRes.body);
        },
      );
    } catch (e) {
      print(e.toString());
      print("Moods Not Found");
      // showSnackBar(context, e.toString());
    }

    return getMoods!;
  }
}
