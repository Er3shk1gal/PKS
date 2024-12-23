import 'package:flutter/material.dart';

class EditProfilePictureDialog extends StatelessWidget {
  final TextEditingController filepathController;
  final VoidCallback onUpdate;

  const EditProfilePictureDialog({
    Key? key,
    required this.filepathController,
    required this.onUpdate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Avatar'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: filepathController,
            decoration: const InputDecoration(labelText: 'Image URL'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: onUpdate,
          child: const Text('Update'),
        ),
      ],
    );
  }
}