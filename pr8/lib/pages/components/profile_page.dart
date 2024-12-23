import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pr8/components/profile/editProfileDialog.dart';
import 'package:pr8/components/profile/editProfilePictureDialog.dart';
import 'package:pr8/components/profile/profileView.dart';
import '../../models/user.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  void _loadUser() {
    setState(() {
      user = Provider.of<User>(context, listen: false);
    });
  }

  void _editProfile() {
    final usernameController = TextEditingController(text: user?.username ?? '');
    final aboutController = TextEditingController(text: user?.about ?? '');

    showDialog(
      context: context,
      builder: (context) {
        return EditProfileDialog(
          usernameController: usernameController,
          aboutController: aboutController,
          onSave: () {
            user?.updateUser(User(
              id: user!.id,
              username: usernameController.text,
              about: aboutController.text,
              profilePicture: user!.profilePicture,
            ));
            debugPrint("Profile updated");
            _loadUser();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _editProfilePicture() {
    final filepathController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return EditProfilePictureDialog(
          filepathController: filepathController,
          onUpdate: () {
            user?.updateUser(User(
              id: user!.id,
              username: user!.username,
              about: user!.about,
              profilePicture: filepathController.text,
            ));
            debugPrint("Profile picture updated");
            _loadUser();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : ProfileView(
              user: user!,
              onEditProfile: _editProfile,
              onEditProfilePicture: _editProfilePicture,
            ),
    );
  }
}