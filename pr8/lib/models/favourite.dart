class Favorite {
  int favoriteID;
  int userID;
  int productID;
  DateTime addedAt;

  Favorite({
    required this.favoriteID,
    required this.userID,
    required this.productID,
    required this.addedAt,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
      favoriteID: json['favorite_id'],
      userID: json['user_id'],
      productID: json['product_id'],
      addedAt: DateTime.parse(json['added_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'favorite_id': favoriteID,
      'user_id': userID,
      'product_id': productID,
      'added_at': addedAt.toIso8601String(),
    };
  }
}