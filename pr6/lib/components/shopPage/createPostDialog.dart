import 'package:flutter/material.dart';
import 'package:pr6/models/good.dart';

class CreatePostDialog extends StatelessWidget {
  final Function(Good) onCreate;

  const CreatePostDialog({
    Key? key,
    required this.onCreate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final priceController = TextEditingController();
    final filePathController = TextEditingController();

    return AlertDialog(
      title: const Text('Create Post'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
          ),
          TextField(
            controller: filePathController,
            decoration: const InputDecoration(labelText: 'Image URL'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            final newPost = Good(
              id: DateTime.now().millisecondsSinceEpoch, // Генерация уникального ID
              title: titleController.text,
              content: descriptionController.text,
              price: int.tryParse(priceController.text) ?? 0,
              filePath: filePathController.text,
            );
            onCreate(newPost);
            Navigator.of(context).pop();
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
