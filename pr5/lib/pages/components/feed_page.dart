import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/post.dart';
import '../../models/comment.dart';
import '../../database/database_helper.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({super.key});

  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final dbHelper = DatabaseHelper.instance;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _loadPosts();
  }

  void _loadPosts() async {
    final data = await dbHelper.getPosts();
    setState(() {
      posts = data;
    });
  }

  void _toggleLike(Post post) async {
    if (post.likedByUser) {
      await dbHelper.deleteLike(post.id, 1);
      setState(() {
        post.likes -= 1;
        post.likedByUser = false;
      });
    } else {
      await dbHelper.insertLike(post.id, 1);
      setState(() {
        post.likes += 1;
        post.likedByUser = true;
      });
    }
    _loadPosts();
  }

  void _deletePost(int postId) async {
    bool confirm = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirm Delete'),
        content: const Text('Are you sure you want to delete this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirm) {
      await dbHelper.deletePost(postId);
      _loadPosts();
    }
  }

  void _createPost() async {
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
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Create Post'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: controller,
                decoration: const InputDecoration(labelText: 'Content'),
              ),
              if (filePath != null) Image.file(File(filePath)),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                dbHelper.insertPost(Post(
                  id: DateTime.now().millisecondsSinceEpoch,
                  content: controller.text,
                  author: 'Author',
                  timestamp: DateTime.now(),
                  filePath: filePath,
                ));
                _loadPosts();
                Navigator.of(context).pop();
              },
              child: const Text('Post'),
            ),
          ],
        );
      },
    );
  }

  void _showComments(Post post) async {
    final comments = await dbHelper.getCommentsForPost(post.id);

    showDialog(
      context: context,
      builder: (context) {
        final controller = TextEditingController();
        return AlertDialog(
          title: const Text('Комментарии'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ...comments.map((comment) => ListTile(title: Text(comment.content), subtitle: Text(comment.author))),
              TextField(controller: controller, decoration: const InputDecoration(labelText: 'Ваш комментарий')),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                dbHelper.insertComment(Comment(
                  id: DateTime.now().millisecondsSinceEpoch,
                  postId: post.id,
                  author: 'Author',
                  content: controller.text,
                  timestamp: DateTime.now(),
                ));
                Navigator.of(context).pop();
              },
              child: const Text('Отправить'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feed'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createPost,
          ),
        ],
      ),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1,
        ),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final post = posts[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.filePath != null)
                  Image.file(
                    File(post.filePath!),
                    width: double.infinity,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(post.content),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      IconButton(
                        icon: Icon(
                          post.likedByUser ? Icons.favorite : Icons.favorite_border,
                          color: post.likedByUser ? Colors.red : null,
                        ),
                        onPressed: () => _toggleLike(post),
                      ),
                      IconButton(
                        icon: const Icon(Icons.comment),
                        onPressed: () => _showComments(post),
                      ),
                      const Spacer(),
                      PopupMenuButton(
                        onSelected: (value) {
                          if (value == 'delete') {
                            _deletePost(post.id);
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(
                            value: 'delete',
                            child: Text('Delete'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
