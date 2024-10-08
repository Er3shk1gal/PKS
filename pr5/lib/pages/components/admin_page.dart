import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/post.dart';
import '../../database/database_helper.dart';

class AdminPage extends StatelessWidget {
  final dbHelper = DatabaseHelper.instance;

   AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Panel'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => _createCustomPost(context),
          ),
        ],
      ),
      body: FutureBuilder<List<Post>>(
        future: dbHelper.getPosts(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final posts = snapshot.data!;
          return ListView(
            children: posts.map((post) => ListTile(
              title: Text(post.content),
              subtitle: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      dbHelper.deletePost(post.id);
                    },
                  ),
                ],
              ),
            )).toList(),
          );
        },
      ),
    );
  }

  void _createCustomPost(BuildContext context) async {
    String? filePath;
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.any,
      allowMultiple: false,
    );

    if (result != null) {
      filePath = result.files.single.path;
    }

    showDialog(
      context: context,
      builder: (context) {
        final contentController = TextEditingController();
        final authorController = TextEditingController(text: 'admin');

        return AlertDialog(
          title: const Text('Create New Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: contentController,
                decoration: const InputDecoration(labelText: 'Content'),
              ),
              TextField(
                controller: authorController,
                decoration: const InputDecoration(labelText: 'Author'),
              ),
              if (filePath != null) Image.file(File(filePath)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await dbHelper.insertPost(Post(
                  id: DateTime.now().millisecondsSinceEpoch,
                  content: contentController.text,
                  author: authorController.text,
                  timestamp: DateTime.now(),
                  filePath: filePath,
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Create'),
            ),
          ],
        );
      },
    );
  }
}
