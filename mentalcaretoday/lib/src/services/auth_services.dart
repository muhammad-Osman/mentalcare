import 'dart:convert';
import 'dart:io';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentalcaretoday/src/UI/views/home_screen.dart';
import 'package:mentalcaretoday/src/UI/views/splash_screen.dart';
import 'package:mentalcaretoday/src/utils/end_points.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UI/views/sign_in_screen.dart';
import '../models/user.dart';
import '../provider/user_provider.dart';
import '../utils/error_handling.dart';
import '../utils/utils.dart';

class AuthService {
  // sign up user
  Future signUpUser({
    required BuildContext context,
    required final String firstName,
    required final String lastName,
    required final String dob,
    required final String city,
    required final String state,
    required final String gender,
    required final String country,
    required final String email,
    required final String password,
    required final String passwordConfirmation,
    final String? image,
  }) async {
    try {
      User user = User(
        id: 0,
        active: false,
        city: city,
        country: country,
        createdAt: "",
        dob: dob.toString(),
        emailVerifiedAt: "",
        firstName: firstName,
        password: password,
        passwordConfirmation: passwordConfirmation,
        gender: gender,
        lastName: lastName,
        lastSceneTime: null,
        premium: false,
        state: state,
        updatedAt: "",
        email: email,
        image: "",
      );

      http.Response res = await http.post(
        Uri.parse(registerUrl),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account created! Login with the same credentials!',
          );
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
              (Route<dynamic> route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  Future signInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(loginUrl),
        body: jsonEncode(
            {'email': email, 'password': password, "social_auth": false}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      final Map<String, dynamic> user = json.decode(res.body);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          final Map<String, dynamic> user = json.decode(res.body);
          Provider.of<UserProvider>(context, listen: false)
              .setUser(user["user"]);
          await prefs.setString('x-auth-token', user['access_token']);
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeScreen()),
              (Route<dynamic> route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  Future getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse(getProfileUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      // ignore: use_build_context_synchronously
      var userProvider = Provider.of<UserProvider>(context, listen: false);
      final Map<String, dynamic> user = json.decode(userRes.body);
      userProvider.setUser(user["user"]);
    } catch (e) {
      print("User Not Found");
      // showSnackBar(context, e.toString());
    }
  }

  // update up user
  Future updateUser({
    required BuildContext context,
    required String firstName,
    required String lastName,
    required String dob,
    required String city,
    required String state,
    required String gender,
    required String country,
    required String email,
    List<File>? images,
  }) async {
    var userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('dddunvhux', 'ku2vssmn');
      List<String> imageUrls = [];
      if (images!.isNotEmpty) {
        for (int i = 0; i < images.length; i++) {
          CloudinaryResponse res = await cloudinary.uploadFile(
            CloudinaryFile.fromFile(images[i].path, folder: "profile"),
          );
          imageUrls.add(res.secureUrl);
        }
      }

      User user = User(
        city: city,
        country: country,
        dob: dob,
        firstName: firstName,
        gender: gender,
        lastName: lastName,
        state: state,
        email: email,
        image: imageUrls.isNotEmpty ? imageUrls[0] : userProvider.user.image,
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      http.Response res = await http.post(
        Uri.parse(updateProfileUrl),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );
      final Map<String, dynamic> userUpadate = json.decode(res.body);

      Provider.of<UserProvider>(context, listen: false)
          .setUser(userUpadate["user"]);
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'Account  is Succesfully Updated!',
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

  // delete  user
  Future deleteAccount({
    required BuildContext context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token == null) {
      prefs.setString('x-auth-token', '');
    }
    try {
      http.Response res = await http.delete(
        Uri.parse(deleteAccountUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          final Map<String, dynamic> user = json.decode(res.body);
          showSnackBar(
            context,
            user["message"],
          );
          await prefs.setString('x-auth-token', "");
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (context) => const SplashScreen(),
              ),
              (Route<dynamic> route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // delete  user
  Future logoutUser({
    required BuildContext context,
  }) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('x-auth-token');

    if (token == null) {
      prefs.setString('x-auth-token', '');
    }
    try {
      http.Response res = await http.post(
        Uri.parse(logoutAccountUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          final Map<String, dynamic> user = json.decode(res.body);
          showSnackBar(
            context,
            user["message"],
          );
          await prefs.setString('x-auth-token', "");
          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SplashScreen()),
              (Route<dynamic> route) => false);
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
