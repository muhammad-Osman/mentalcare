import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentalcaretoday/src/UI/views/home_screen.dart';
import 'package:mentalcaretoday/src/utils/end_points.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/error_handling.dart';
import '../utils/utils.dart';

class FeedBackServices {
  // add feedback
  Future addFeedback({
    required BuildContext context,
    required final String message,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token == null) {
      prefs.setString('x-auth-token', '');
    }

    try {
      http.Response res = await http.post(
        Uri.parse(addFeedbackUrl),
        body: jsonEncode({"message": message}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Feedback Added Successfuly!',
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
