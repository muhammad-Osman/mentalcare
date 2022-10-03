import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mentalcaretoday/src/UI/views/home_screen.dart';
import 'package:mentalcaretoday/src/UI/views/splash_screen.dart';
import 'package:mentalcaretoday/src/utils/end_points.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../UI/views/sign_in_screen.dart';
import '../UI/views/sign_up_screen.dart';
import '../models/user.dart';
import '../provider/other_user_provider.dart';
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
        currentMood: null,
        currentMoodId: null,
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
            'Account created! please verifiy your email',
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

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
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
      print(res.body);
      print(res.statusCode);
      final Map<String, dynamic> user = json.decode(res.body);
      print(user);

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          final Map<String, dynamic> user = json.decode(res.body);
          print(user);

          Provider.of<UserProvider>(context, listen: false)
              .setUser(user["user"]);
          final userData =
              Provider.of<UserProvider>(context, listen: false).user;

          CurrentMood currentMood = CurrentMood(
            id: userData.currentMood?.id,
            name: userData.currentMood?.name,
            color: userData.currentMood?.color,
            createdAt: userData.currentMood?.createdAt,
            updatedAt: userData.currentMood?.updatedAt,
            deletedAt: userData.currentMood?.deletedAt,
          );
          User _user = User(
            id: userData.id,
            currentMoodId: userData.currentMood?.id != null
                ? userData.currentMoodId
                : null,
            active: userData.active,
            city: userData.city,
            country: userData.country,
            createdAt: userData.createdAt,
            dob: userData.dob,
            emailVerifiedAt: userData.emailVerifiedAt,
            firstName: userData.firstName,
            gender: userData.gender,
            lastName: userData.lastName,
            lastSceneTime: userData.lastSceneTime,
            premium: userData.premium,
            state: userData.state,
            updatedAt: userData.updatedAt,
            email: userData.email,
            image: userData.image,
            password: userData.password,
            currentMood: userData.currentMood?.id != null ? currentMood : null,
            passwordConfirmation: userData.passwordConfirmation,
          );
          print(userData.currentMood?.name);
          await firestore
              .collection('users')
              .doc(userData.id.toString())
              .set(_user.toMap())
              .then((value) => print("User Added"))
              .catchError((error) => print("Failed to add user: $error"));
          ;
          await prefs.setString('x-auth-token', user['access_token']);
          await prefs.setBool('isFirstRun', true);
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

// sign in user
  Future signInGoogle({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(loginUrl),
        body: jsonEncode({'email': email, "social_auth": true}),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(res.body);
      print(res.statusCode);
      final Map<String, dynamic> user = json.decode(res.body);
      print(user);
      if (user["message"] == "The user does not exists") {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const SignUpScreen()),
        );
      }
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          // ignore: use_build_context_synchronously
          final Map<String, dynamic> user = json.decode(res.body);
          print(user);

          Provider.of<UserProvider>(context, listen: false)
              .setUser(user["user"]);
          final userData =
              Provider.of<UserProvider>(context, listen: false).user;
          CurrentMood currentMood = CurrentMood(
            id: userData.currentMood?.id,
            name: userData.currentMood?.name,
            color: userData.currentMood?.color,
            createdAt: userData.currentMood?.createdAt,
            updatedAt: userData.currentMood?.updatedAt,
            deletedAt: userData.currentMood?.deletedAt,
          );
          User _user = User(
            id: userData.id,
            currentMoodId: userData.currentMood?.id != null
                ? userData.currentMoodId
                : null,
            active: userData.active,
            city: userData.city,
            country: userData.country,
            createdAt: userData.createdAt,
            dob: userData.dob,
            emailVerifiedAt: userData.emailVerifiedAt,
            firstName: userData.firstName,
            gender: userData.gender,
            lastName: userData.lastName,
            lastSceneTime: userData.lastSceneTime,
            premium: userData.premium,
            state: userData.state,
            updatedAt: userData.updatedAt,
            email: userData.email,
            image: userData.image,
            password: userData.password,
            currentMood: userData.currentMood?.id != null ? currentMood : null,
            passwordConfirmation: userData.passwordConfirmation,
          );
          await firestore
              .collection('users')
              .doc(userData.id.toString())
              .set(_user.toMap());

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

  // forgot Password
  Future forgotPassword({
    required BuildContext context,
    required String email,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse(forgotPasswordUrl),
        body: jsonEncode({
          'email': email,
        }),
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

          // ignore: use_build_context_synchronously
          Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const SignInScreen()),
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

  // get user data
  Future getUserDataById(BuildContext context, int id) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse("$getUserByIdUrl$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      // ignore: use_build_context_synchronously
      var userProvider = Provider.of<OtherUserProvider>(context, listen: false);
      final Map<String, dynamic> user = json.decode(userRes.body);
      userProvider.setUser(user["user"]);
    } catch (e) {
      print("User Not Found");
      // showSnackBar(context, e.toString());
    }
  }

  // get user data
  Future<UserTokenResponse?> getUserById(BuildContext context, int id) async {
    UserTokenResponse? userTokenResponse;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse("$getUserByIdUrl$id"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );

      // ignore: use_build_context_synchronously
      var userProvider = Provider.of<OtherUserProvider>(context, listen: false);
      final Map<String, dynamic> user = json.decode(userRes.body);
      print(userRes.body);
      userTokenResponse = userTokenFromJson(userRes.body);
    } catch (e) {
      print("User Not Found");
      // showSnackBar(context, e.toString());
    }
    return userTokenResponse;
  }

// get user data
  Future<List<User>?> getAllUser(
    BuildContext context,
  ) async {
    UserResponse? userResponse;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse(allUserUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );
      print(userRes.body);
      // ignore: use_build_context_synchronously

      final Map<String, dynamic> user = json.decode(userRes.body);

      httpErrorHandle(
        response: userRes,
        context: context,
        onSuccess: () {
          userResponse = userFromJson(userRes.body);
        },
      );
      return userResponse!.users;
    } catch (e) {
      print("User Not Found");
      // showSnackBar(context, e.toString());
    }
  }

  Future<List<User>?> searchUser(BuildContext context, String name) async {
    UserResponse? userResponse;
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      http.Response userRes = await http.get(
        Uri.parse(allUserUrl).replace(
          queryParameters: {
            "q": name,
          },
        ),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': "Bearer $token"
        },
      );
      print(userRes.body);
      // ignore: use_build_context_synchronously

      final Map<String, dynamic> user = json.decode(userRes.body);

      httpErrorHandle(
        response: userRes,
        context: context,
        onSuccess: () {
          userResponse = userFromJson(userRes.body);
        },
      );
      return userResponse!.users;
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
      //   final cloudinary = CloudinaryPublic('dddunvhux', 'ku2vssmn');
      //   List<String> imageUrls = [];
      //   if (images!.isNotEmpty) {
      //     for (int i = 0; i < images.length; i++) {
      //       CloudinaryResponse res = await cloudinary.uploadFile(
      //         CloudinaryFile.fromFile(images[i].path, folder: "profile"),
      //       );
      //       imageUrls.add(res.secureUrl);
      //     }
      //   }

      // print(imageUrls[0]);

      User user = User(
        city: city,
        country: country,
        dob: dob,
        firstName: firstName,
        gender: gender,
        lastName: lastName,
        state: state,
        email: email,
        image: userProvider.user.image,
      );
      print(user.image);
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }
      //for multipartrequest
      var request = http.MultipartRequest('POST', Uri.parse(updateProfileUrl));
      request.fields["first_name"] = user.firstName;
      request.fields["last_name"] = user.lastName;
      request.fields["dob"] = user.dob;
      request.fields["gender"] = user.gender;
      request.fields["city"] = user.city;
      request.fields["state"] = user.state;
      request.fields["country"] = user.country;
      //for token
      request.headers.addAll({
        "Authorization": "Bearer $token",
        'Content-Type': 'application/json; charset=UTF-8',
      });

      //for image and videos and files
      if (images!.isNotEmpty) {
        request.files.add(http.MultipartFile.fromBytes(
            'profile_picture', images[0].readAsBytesSync(),
            filename: images[0].path.split("/").last));
      }

      //for completeing the request
      var response = await request.send();

      //for getting and decoding the response into json format
      var res = await http.Response.fromStream(response);
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
