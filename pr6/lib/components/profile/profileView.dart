import 'package:flutter/material.dart';
import 'package:pr6/models/user.dart';

class ProfileView extends StatelessWidget {
  final User user;
  final VoidCallback onEditProfile;
  final VoidCallback onEditProfilePicture;

  const ProfileView({
    Key? key,
    required this.user,
    required this.onEditProfile,
    required this.onEditProfilePicture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              GestureDetector(
                onTap: onEditProfilePicture,
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: user.profilePicture != null
                      ? NetworkImage(user.profilePicture!)
                      : const AssetImage('assets/profile.png') as ImageProvider,
                ),
              ),
              const SizedBox(height: 20),
              Text(user.username, style: const TextStyle(fontSize: 24)),
              const SizedBox(height: 10),
              Text(user.about ?? '', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: onEditProfile,
                child: const Text('Edit Profile'),
              ),
            ],
          ),
        ),
        const Divider(),
      ],
    );
  }
}