import 'package:flutter/material.dart';

class User extends ChangeNotifier {
  int id;
  String username;
  String? profilePicture;
  String? about;

  User({
    required this.id,
    required this.username,
    this.profilePicture,
    this.about,
  });

  void updateUser(User user) {
    id = user.id;
    username = user.username;
    profilePicture = user.profilePicture;
    about = user.about;
    notifyListeners();
  }
}