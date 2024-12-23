class Product {
  int productID;
  String name;
  String description;
  double price;
  int stock;
  String imageURL;

  Product({
    required this.productID,
    required this.name,
    required this.description,
    required this.price,
    required this.stock,
    required this.imageURL,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      productID: json['product_id'],
      name: json['name'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      imageURL: json['image_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'product_id': productID,
      'name': name,
      'description': description,
      'price': price,
      'stock': stock,
      'image_url': imageURL,
    };
  }
}
