import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/post.dart';
import '../models/user.dart';
import '../models/comment.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('app.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY,
        username TEXT,
        profilePicture TEXT,
        about TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE posts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        content TEXT,
        author TEXT,
        timestamp TEXT,
        likes INTEGER DEFAULT 0,
        reposts INTEGER DEFAULT 0,
        filePath TEXT,
        originalAuthor TEXT,
        likedByUser INTEGER DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE TABLE comments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        postId INTEGER,
        author TEXT,
        content TEXT,
        timestamp TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE likes (
        userId INTEGER,
        postId INTEGER,
        PRIMARY KEY (userId, postId)
      )
    ''');

    await db.insert('users', {
      'id': 1,
      'username': 'Default User',
      'profilePicture': null,
      'about': 'About me',
    });
  }

  Future<User?> getUser() async {
    final db = await instance.database;
    final result = await db.query('users', where: 'id = ?', whereArgs: [1]);

    if (result.isNotEmpty) {
      return User.fromJson(result.first);
    }
    return null;
  }

  Future<void> updateUser(User user) async {
    final db = await instance.database;
    await db.update('users', user.toJson(), where: 'id = ?', whereArgs: [user.id]);
  }

  Future<List<Post>> getPosts() async {
    final db = await instance.database;
    final result = await db.query('posts');

    return result.map((json) {
      final post = Post.fromJson(json);
      post.likedByUser = json['likedByUser'] == 1;
      return post;
    }).toList();
  }

  Future<List<Post>> getUserPosts(int userId) async {
    final db = await instance.database;
    final result = await db.query('posts', where: 'author = ?', whereArgs: [userId]);

    return result.map((json) {
      final post = Post.fromJson(json);
      post.likedByUser = json['likedByUser'] == 1;
      return post;
    }).toList();
  }

  Future<void> insertPost(Post post) async {
    final db = await instance.database;
    await db.insert('posts', post.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> likePost(int postId, int userId) async {
    final db = await instance.database;
    final likes = await db.query('likes', where: 'userId = ? AND postId = ?', whereArgs: [userId, postId]);

    if (likes.isEmpty) {
      await db.insert('likes', {'userId': userId, 'postId': postId});
      await db.rawUpdate('UPDATE posts SET likes = likes + 1, likedByUser = 1 WHERE id = ?', [postId]);
    } else {
      await db.delete('likes', where: 'userId = ? AND postId = ?', whereArgs: [userId, postId]);
      await db.rawUpdate('UPDATE posts SET likes = likes - 1, likedByUser = 0 WHERE id = ?', [postId]);
    }
  }

  Future<void> insertLike(int postId, int userId) async {
    final db = await instance.database;
    await db.insert('likes', {'userId': userId, 'postId': postId});
    await db.rawUpdate('UPDATE posts SET likes = likes + 1, likedByUser = 1 WHERE id = ?', [postId]);
  }

  Future<void> deleteLike(int postId, int userId) async {
    final db = await instance.database;
    await db.delete('likes', where: 'userId = ? AND postId = ?', whereArgs: [userId, postId]);
    await db.rawUpdate('UPDATE posts SET likes = likes - 1, likedByUser = 0 WHERE id = ?', [postId]);
  }


  Future<void> deletePost(int postId) async {
    final db = await instance.database;
    await db.delete('posts', where: 'id = ?', whereArgs: [postId]);
  }

  Future<void> insertComment(Comment comment) async {
    final db = await instance.database;
    await db.insert('comments', comment.toJson());
  }

  Future<List<Comment>> getCommentsForPost(int postId) async {
    final db = await instance.database;
    final result = await db.query('comments', where: 'postId = ?', whereArgs: [postId]);

    return result.map((json) => Comment.fromJson(json)).toList();
  }

  Future<void> deleteComment(int commentId) async {
    final db = await instance.database;
    await db.delete('comments', where: 'id = ?', whereArgs: [commentId]);
  }

  Future<void> deleteCommentsByUser(String username) async {
    final db = await instance.database;
    await db.delete('comments', where: 'author = ?', whereArgs: [username]);
  }

  Future<List<Post>> getFavoritePosts() async {
    final db = await instance.database;
    final result = await db.query('posts', where: 'likes > ?', whereArgs: [0]);

    return result.map((json) => Post.fromJson(json)).toList();
  }
}
