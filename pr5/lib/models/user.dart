class User {
  final int id;
  final String username;
  final String? profilePicture;
  final String? about;

  User({
    required this.id,
    required this.username,
    this.profilePicture,
    this.about,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      profilePicture: json['profilePicture'],
      about: json['about'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'profilePicture': profilePicture,
      'about': about,
    };
  }
}
