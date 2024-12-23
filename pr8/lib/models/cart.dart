class Cart {
  int cartID;
  int userID;
  int productID;
  int quantity;
  DateTime addedAt;

  Cart({
    required this.cartID,
    required this.userID,
    required this.productID,
    required this.quantity,
    required this.addedAt,
  });

  factory Cart.fromJson(Map<String, dynamic> json) {
    return Cart(
      cartID: json['cart_id'],
      userID: json['user_id'],
      productID: json['product_id'],
      quantity: json['quantity'],
      addedAt: DateTime.parse(json['added_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cart_id': cartID,
      'user_id': userID,
      'product_id': productID,
      'quantity': quantity,
      'added_at': addedAt.toIso8601String(),
    };
  }
}