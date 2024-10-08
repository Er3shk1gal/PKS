import 'dart:io';
import 'package:flutter/material.dart';
import '../../models/post.dart';
import '../../database/database_helper.dart';

class FavoritesPage extends StatefulWidget {
  const FavoritesPage({super.key});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final dbHelper = DatabaseHelper.instance;
  List<Post> favoritePosts = [];

  @override
  void initState() {
    super.initState();
    _loadFavoritePosts();
  }

  void _loadFavoritePosts() async {
    final data = await dbHelper.getFavoritePosts();
    setState(() {
      favoritePosts = data;
    });
  }

  void _toggleFavorite(Post post) async {
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
    _loadFavoritePosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: favoritePosts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 4,
          mainAxisSpacing: 4,
          childAspectRatio: 1,
        ),
        itemCount: favoritePosts.length,
        itemBuilder: (context, index) {
          final post = favoritePosts[index];
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
                        onPressed: () => _toggleFavorite(post),
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
