import 'package:flutter/material.dart';
import 'package:pr8/models/product.dart';

class EditPostDialog extends StatelessWidget {
  final Product post;
  final Function(Product) onSave;

  const EditPostDialog({
    Key? key,
    required this.post,
    required this.onSave,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController(text: post.name);
    final priceController = TextEditingController(text: post.price.toString());
    final contentController = TextEditingController(text: post.description);
    final filePathController = TextEditingController(text: post.imageURL);

    return AlertDialog(
      title: const Text('Edit Good'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: priceController,
            decoration: const InputDecoration(labelText: 'Price'),
          ),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(labelText: 'Description'),
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
            final updatedPost = Product(
              productID: post.productID,
              name: titleController.text,
              price: double.parse(priceController.text),
              description: contentController.text,
              imageURL: filePathController.text,
              stock: post.stock
            );
            onSave(updatedPost);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}