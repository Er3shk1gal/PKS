import 'package:flutter/material.dart';

class EditProfileDialog extends StatelessWidget {
  final TextEditingController usernameController;
  final TextEditingController aboutController;
  final VoidCallback onSave;

  const EditProfileDialog({
    Key? key,
    required this.usernameController,
    required this.aboutController,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Profile'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: aboutController,
            decoration: const InputDecoration(labelText: 'About'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onSave,
          child: const Text('Save'),
        ),
      ],
    );
  }
}
