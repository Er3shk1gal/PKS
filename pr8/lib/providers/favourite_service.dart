import 'package:dio/dio.dart';
import 'package:pr8/models/favourite.dart';

class FavoritesService {
  final Dio _dio;

  FavoritesService(this._dio);


  final String baseUrl = 'http://localhost:8080';

  Future<List<Favorite>> getFavorites(int userId) async {
    try {
      final response = await _dio.get('$baseUrl/favorites/$userId');
      List<Favorite> favoriteItems = (response.data as List)
          .map((item) => Favorite.fromJson(item))
          .toList();
      return favoriteItems;
    } catch (e) {
      throw Exception('Failed to load favorites: $e');
    }
  }

  Future<void> addToFavorites(int userId, int productId) async {
    try {
      final response = await _dio.post(
        '$baseUrl/favorites/$userId',
        data: {
          'product_id': productId,
        },
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to add item to favorites');
      }
    } catch (e) {
      throw Exception('Failed to add item to favorites: $e');
    }
  }


  Future<void> removeFromFavorites(int userId, int productId) async {
    try {
      final response = await _dio.delete('$baseUrl/favorites/$userId/$productId');
      if (response.statusCode != 200) {
        throw Exception('Failed to remove item from favorites');
      }
    } catch (e) {
      throw Exception('Failed to remove item from favorites: $e');
    }
  }
}
