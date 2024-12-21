import 'package:flutter/material.dart';
import 'package:pr7/components/profilepage/logoutButton.dart';
import 'package:pr7/components/profilepage/profileHeader.dart';
import 'package:pr7/components/profilepage/profileInfo.dart';
import 'package:pr7/components/profilepage/profileLinks.dart';
import 'package:pr7/components/profilepage/profileOptions.dart';

class ProfilePage extends StatelessWidget {
  final Color phoneColor;
  final Color emailColor;
  final Color linkColor;

  const ProfilePage({
    super.key,
    this.phoneColor = Colors.black38,
    this.emailColor = Colors.black38,
    this.linkColor = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль', style: TextStyle(fontFamily: 'Montserrat')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const ProfileHeader(name: 'Эдуард'),
            const SizedBox(height: 8),
            ProfileInfo(text: '+7 900 800-55-33', color: phoneColor),
            const SizedBox(height: 8),
            ProfileInfo(text: 'email@gmail.com', color: emailColor),
            const SizedBox(height: 32),
            const ProfileOptions(),
            const Spacer(),
            const ProfileLinks(),
            const SizedBox(height: 16),
            const LogoutButton(),
          ],
        ),
      ),
    );
  }
}
