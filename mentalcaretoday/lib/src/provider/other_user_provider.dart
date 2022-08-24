import 'package:flutter/material.dart';

import '../models/user.dart';

class OtherUserProvider extends ChangeNotifier {
  User _user = User(
    id: 0,
    active: false,
    city: "",
    country: "",
    createdAt: '',
    dob: "",
    emailVerifiedAt: '',
    firstName: '',
    gender: '',
    lastName: '',
    lastSceneTime: '',
    premium: false,
    state: '',
    updatedAt: '',
    email: '',
    image: '',
    password: '',
    passwordConfirmation: '',
  );

  User get user => _user;

  void setUser(Map<String, dynamic> user) {
    _user = User.fromJson(user);
    notifyListeners();
  }

  void setUserFromModel(User user) {
    _user = user;
    notifyListeners();
  }
}
