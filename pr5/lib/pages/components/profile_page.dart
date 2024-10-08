import 'dart:io';
import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import '../../models/user.dart';
import '../../models/post.dart';
import '../../models/comment.dart';
import '../../database/database_helper.dart';

class ProfilePage extends StatefulWidget {
  final User user;

  const ProfilePage({super.key, required this.user});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final dbHelper = DatabaseHelper.instance;
  User? user;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    _loadUser();
    _loadPosts();
  }

  void _loadUser() async {
    final data = await dbHelper.getUser();
    setState(() {
      user = data ?? User(id: 1, username: 'Default User', about: 'About me');
    });
  }

  void _loadPosts() async {
    final data = await dbHelper.getUserPosts(user?.id ?? 1);
    setState(() {
      posts = data;
    });
  }

  void _editProfile() async {
    final usernameController = TextEditingController(text: user?.username ?? '');
    final aboutController = TextEditingController(text: user?.about ?? '');

    showDialog(
      context: context,
      builder: (context) {
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
              onPressed: () async {
                await dbHelper.updateUser(User(
                  id: user!.id,
                  username: usernameController.text,
                  about: aboutController.text,
                  profilePicture: user!.profilePicture,
                ));
                debugPrint("Profile updated");
                _loadUser();
                Navigator.of(context).pop();
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  void _editProfilePicture() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null) {
      String? imagePath = result.files.single.path;
      if (imagePath != null) {
        await dbHelper.updateUser(User(
          id: user!.id,
          username: user!.username,
          about: user!.about,
          profilePicture: imagePath,
        ));
        await dbHelper.insertPost(Post(
          id: DateTime.now().millisecondsSinceEpoch,
          content: 'Updated profile picture',
          author: user!.username,
          timestamp: DateTime.now(),
          filePath: imagePath,
        ));
        debugPrint("Profile picture updated and post created");
        _loadUser();
        _loadPosts();
      }
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
                onPressed: () async {
                  await dbHelper.insertPost(Post(
                    id: DateTime.now().millisecondsSinceEpoch,
                    content: controller.text,
                    author: user!.username,
                    timestamp: DateTime.now(),
                    filePath: filePath,
                  ));
                  debugPrint("New post created");
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
  }

  void _toggleLike(int postId) async {
    await dbHelper.likePost(postId, user!.id);
    debugPrint("Toggled like for post $postId");
    _loadPosts();
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
              onPressed: () async {
                await dbHelper.insertComment(Comment(
                  id: DateTime.now().millisecondsSinceEpoch,
                  postId: post.id,
                  author: user!.username,
                  content: controller.text,
                  timestamp: DateTime.now(),
                ));
                debugPrint("Comment added to post ${post.id}");
                Navigator.of(context).pop();
              },
              child: const Text('Отправить'),
            ),
          ],
        );
      },
    );
  }

  void _deletePost(int postId) async {
    await dbHelper.deletePost(postId);
    debugPrint("Deleted post $postId");
    _loadPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _createPost,
          ),
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  onTap: _editProfilePicture,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: user!.profilePicture != null
                        ? FileImage(File(user!.profilePicture!))
                        : const AssetImage('assets/profile.png') as ImageProvider,
                  ),
                ),
                const SizedBox(height: 20),
                Text(user!.username, style: const TextStyle(fontSize: 24)),
                const SizedBox(height: 10),
                Text(user!.about ?? '', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _editProfile,
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
          ),
          const Divider(),
          ...posts.map((post) => ListTile(
            title: Text(post.content),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (post.filePath != null)
                  Image.file(File(post.filePath!), width: MediaQuery.of(context).size.width - 40, height: 200, fit: BoxFit.cover),
                Text('Likes: ${post.likes} • Reposts: ${post.reposts}'),
                Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        post.likedByUser ? Icons.favorite : Icons.favorite_border,
                        color: post.likedByUser ? Colors.red : null,
                      ),
                      onPressed: () => _toggleLike(post.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.comment),
                      onPressed: () => _showComments(post),
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () async {
                        await dbHelper.insertPost(Post(
                          id: DateTime.now().millisecondsSinceEpoch,
                          content: post.content,
                          author: user!.username,
                          timestamp: DateTime.now(),
                          filePath: post.filePath,
                          originalAuthor: post.author,
                        ));
                        debugPrint("Reposted post ${post.id}");
                        _loadPosts();
                      },
                    ),
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
              ],
            ),
          )),
        ],
      ),
    );
  }
}
