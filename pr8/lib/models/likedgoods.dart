import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pr8/models/favourite.dart';
import 'package:pr8/models/product.dart';
import 'package:pr8/providers/favourite_service.dart';
import 'package:pr8/providers/product_service.dart';

class LikedGoods extends ChangeNotifier {
  List<Product> _goods = [];
  List<Favorite> _favorites = [];
  List<Product> get goods => List.unmodifiable(_goods);
  List<Favorite> get favorites => List.unmodifiable(_favorites);
  late ProductsService _productsService = ProductsService(Dio());
  late FavoritesService _favoritesService = FavoritesService(Dio());
  int userId;
  LikedGoods({required this.userId});
  Future<void> loadGoods() async
  {
    var products = await _productsService.getProducts();
    _goods = products.where((item) => _favorites.any((item2) => item2.productID == item.productID)).toList();
    notifyListeners();
  }
  Future<void> loadFavorites(int userId) async
  {
    _favorites = await _favoritesService.getFavorites(userId);
    notifyListeners();
  }
  Future<void> addGood(Product good) async {
    final existingGood = _findGood(good.productID);

    if(existingGood.productID!=-1){
      return;
    }

    await _favoritesService.addToFavorites(userId, good.productID);
    loadFavorites(userId);
    loadGoods();
    notifyListeners();
  }

  Future<void> removeGood(Product good) async {
    final existingGood = _findGood(good.productID);
    if(existingGood.productID==-1){
      return;
    }
    await _favoritesService.removeFromFavorites(userId, good.productID);
    await loadFavorites(userId);
    await loadGoods();
    notifyListeners();
  }
  bool findGood(int id) {
    Product good = _goods.firstWhere(
      (item) => item.productID == id,
      orElse: () => new Product(productID: -1, name: '', description: '', price: 0, stock: 0, imageURL: ''),
    );
    return good.productID == id;
  }
  Product _findGood(int id) {
    return _goods.firstWhere(
      (item) => item.productID == id,
      orElse: () => new Product(productID: -1, name: '', description: '', price: 0, stock: 0, imageURL: ''),
    );
  }
}