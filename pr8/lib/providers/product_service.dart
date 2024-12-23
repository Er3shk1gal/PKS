import 'package:dio/dio.dart';
import 'package:pr8/models/product.dart';

class ProductsService {
  final Dio _dio;

  ProductsService(this._dio);

  // Base URL of your API
  final String baseUrl = 'http://your-api-url'; // Replace with your actual API URL

  // Get all products
  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get('$baseUrl/products');
      List<Product> products = (response.data as List)
          .map((item) => Product.fromJson(item))
          .toList();
      return products;
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }

  // Get a single product by ID
  Future<Product> getProduct(int productId) async {
    try {
      final response = await _dio.get('$baseUrl/products/$productId');
      return Product.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load product: $e');
    }
  }

  // Create a new product
  Future<Product> createProduct(Product product) async {
    try {
      final response = await _dio.post(
        '$baseUrl/products',
        data: product.toJson(),
      );
      return Product.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to create product: $e');
    }
  }

  // Update an existing product
  Future<Product> updateProduct(Product product) async {
    try {
      final response = await _dio.put(
        '$baseUrl/products/${product.productID}',
        data: product.toJson(),
      );
      return Product.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  // Delete a product by ID
  Future<void> deleteProduct(int productId) async {
    try {
      await _dio.delete('$baseUrl/products/$productId');
    } catch (e) {
      throw Exception('Failed to delete product: $e');
    }
  }
}
