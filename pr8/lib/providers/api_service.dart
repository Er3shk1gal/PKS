import 'package:dio/dio.dart';
import 'package:pr8/models/cart.dart';
class CartService {
  final Dio _dio;

  CartService(this._dio);

  // Base URL of your API
  final String baseUrl = 'http://localhost:8080'; // Replace with your actual API URL

  // Get all items in the cart for a specific user
  Future<List<Cart>> getCart(int userId) async {
    try {
      final response = await _dio.get('$baseUrl/carts/$userId');
      List<Cart> cartItems = (response.data as List)
          .map((item) => Cart.fromJson(item))
          .toList();
      return cartItems;
    } catch (e) {
      throw Exception('Failed to load cart: $e');
    }
  }

  // Add an item to the cart
  Future<void> addToCart(int userId, int productId, int quantity) async {
    try {
      final response = await _dio.post(
        '$baseUrl/carts/$userId',
        data: {
          'product_id': productId,
          'quantity': quantity,
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add item to cart');
      }
    } catch (e) {
      throw Exception('Failed to add item to cart: $e');
    }
  }

  // Remove an item from the cart
  Future<void> removeFromCart(int userId, int productId) async {
    try {
      final response = await _dio.delete('$baseUrl/carts/$userId/$productId');
      if (response.statusCode != 200) {
        throw Exception('Failed to remove item from cart');
      }
    } catch (e) {
      throw Exception('Failed to remove item from cart: $e');
    }
  }
}
