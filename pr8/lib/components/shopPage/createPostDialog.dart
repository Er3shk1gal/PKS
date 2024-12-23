import 'package:flutter/material.dart';
import 'package:pr8/models/product.dart';

class CreatePostDialog extends StatelessWidget {
  final Function(Product) onCreate;

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
            decoration: const InputDecoration(labelText: 'Name'),
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
            final newPost = Product(
              productID: DateTime.now().millisecondsSinceEpoch, // Генерация уникального ID
              name: titleController.text,
              description: descriptionController.text,
              price: double.tryParse(priceController.text) ?? 0,
              imageURL: filePathController.text,
              stock: 1,
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
