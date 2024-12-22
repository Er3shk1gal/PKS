import 'package:flutter/material.dart';
import 'package:pr6/models/good.dart';

class EditPostDialog extends StatelessWidget {
  final Good post;
  final Function(Good) onSave;

  const EditPostDialog({
    Key? key,
    required this.post,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: post.title);
    final priceController = TextEditingController(text: post.price.toString());
    final contentController = TextEditingController(text: post.content);
    final filePathController = TextEditingController(text: post.filePath);

    return AlertDialog(
      title: const Text('Edit Good'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
          ),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
          TextField(
            controller: filePathController,
            decoration: const InputDecoration(labelText: 'File Path'),
          ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        TextButton(
          child: const Text('Save'),
          onPressed: () {
            final updatedPost = Good(
              id: post.id,
              title: titleController.text,
              price: int.parse(priceController.text),
              content: contentController.text,
              filePath: filePathController.text,
            );
            onSave(updatedPost);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}