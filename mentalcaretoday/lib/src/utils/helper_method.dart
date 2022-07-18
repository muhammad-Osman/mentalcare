import 'dart:convert';
import 'package:flutter/material.dart';

class Helper {
  static dynamicFont(BuildContext context, double fontSize) {
    final mediaQuery = MediaQuery.of(context).size;

    return ((mediaQuery.height + mediaQuery.width) / 100) * fontSize;
  }

  static dynamicWidth(BuildContext context, double width) {
    final mediaQuery = MediaQuery.of(context).size;

    return (mediaQuery.width / 100) * width;
  }

  static dynamicHeight(BuildContext context, double height) {
    final mediaQuery = MediaQuery.of(context).size;

    return (mediaQuery.height / 100) * height;
  }

  // join multiple errors
  static String getValuesFromMap(Map<String, dynamic> result) {
    List<String> resultConcator = [];
    String output;

    for (var value in result.values) {
      resultConcator.add(value[0]);
    }
    resultConcator.join();

    output = resultConcator.join('\n');
    // print(output);
    return output;
  }

  // give time like 3 minutes/seconds ago etc
  static String getFormattedDate(DateTime date) {
    DateTime _dateTime = DateTime.now().toLocal();
    DateTime newDate = date.toLocal();
    int inDays = _dateTime.difference(date.toLocal()).inDays;
    int inHours = _dateTime.difference(date.toLocal()).inHours;
    int inMinutes = _dateTime.difference(date.toLocal()).inMinutes;
    int inSeconds = _dateTime.difference(date.toLocal()).inSeconds;

    if (_dateTime.year == newDate.year) {
      if (_dateTime.month == newDate.month) {
        if (_dateTime.day == newDate.day) {
          if (inHours > 0) {
            return "${inHours} hours";
          } else if (inMinutes > 0) {
            return "${inMinutes} minutes";
          } else {
            return "${inSeconds} seconds";
          }
        } else if (inDays == 1 || inDays == 0) {
          return "yesterday";
        } else {
          return "Earlier";
        }
      }
      return "Earlier";
    }

    return "Earlier";
  }

  //error handler for single/multiple errors
  static List errorHandler(String val) {
    List<String> results = [];
    List<String> resultConcator = [];
    String output;

    val.toString().substring(0, 2);
    results.add(val.toString().substring(0, 3));

    Map<String, dynamic> errors =
        json.decode(val.toString().substring(3, val.toString().length));

    if (errors.values.length > 1) {
      for (var value in errors['errors'].values) {
        resultConcator.add(value[0]);
      }
      resultConcator.join();

      output = resultConcator.join('\n');

      results.add(output);
    } else {
      results.add(errors['message']);
    }

    return results;
  }

  static String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    final hour = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    return [
      if (duration.inHours > 0) hour,
      minutes,
      seconds,
    ].join(':');
  }
}
