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
      print(userRes.body);
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

  Future addrecording({
    required BuildContext context,
    required final String path,
    required final String affirmationId,
    required final String name,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token == null) {
      prefs.setString('x-auth-token', '');
    }

    try {
      //for multipartrequest
      var request = http.MultipartRequest('POST', Uri.parse(addRecordingUrl));
      request.fields["affirmation_id"] = affirmationId;
      request.fields["name"] = name;
      //for token
      request.headers.addAll({"Authorization": "Bearer $token"});

      //for image and videos and files

      request.files.add(await http.MultipartFile.fromPath("recording", path));

      //for completeing the request
      var response = await request.send();

      //for getting and decoding the response into json format
      var responsed = await http.Response.fromStream(response);
      print(responsed.body);
      final responseData = json.decode(responsed.body);

      httpErrorHandle(
        response: responsed,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Payment Detail Added Successfuly!',
          );
          Navigator.of(context).pop();
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const HomeScreen(),
              ));
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
