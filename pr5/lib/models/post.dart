class Post {
  final int id;
  final String content;
  final String author;
  final DateTime timestamp;
  int likes; // Убрали 'final'
  int reposts;
  final String? filePath;
  final String? originalAuthor;
  bool likedByUser;

  Post({
    required this.id,
    required this.content,
    required this.author,
    required this.timestamp,
    this.likes = 0,
    this.reposts = 0,
    this.filePath,
    this.originalAuthor,
    this.likedByUser = false,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      content: json['content'],
      author: json['author'],
      timestamp: DateTime.parse(json['timestamp']),
      likes: json['likes'],
      reposts: json['reposts'],
      filePath: json['filePath'],
      originalAuthor: json['originalAuthor'],
      likedByUser: json['likedByUser'] == 1,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'author': author,
      'timestamp': timestamp.toIso8601String(),
      'likes': likes,
      'reposts': reposts,
      'filePath': filePath,
      'originalAuthor': originalAuthor,
      'likedByUser': likedByUser ? 1 : 0,
    };
  }
}
