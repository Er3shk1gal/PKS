import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pr8/models/cart.dart';
import 'package:pr8/models/product.dart';
import 'package:pr8/providers/api_service.dart';
import 'package:pr8/providers/product_service.dart';

class ShoppingCart extends ChangeNotifier {
  List<Product> _goods = [];
  List<Cart> _cart = [];
  List<Product> get goods => List.unmodifiable(_goods);
  List<Cart> get cart => List.unmodifiable(_cart);
  int userId;
  ShoppingCart({required this.userId});
  late ProductsService _productsService = ProductsService(Dio());
  late CartService _cartService = CartService(Dio());
  Future<void> loadGoods() async
  {
    var products = await _productsService.getProducts();
    _goods = products.where((item) => _cart.any((item2) => item2.productID == item.productID)).toList();
    notifyListeners();
  }
  Future<void> loadCart(int userId) async
  {
    _cart = await _cartService.getCart(userId);
    notifyListeners();
  }
  Future<void> addGood(Product good) async {
    final existingGood = _findGood(good.productID);
    if(existingGood.productID==-1){
      await _cartService.removeFromCart(userId, good.productID);
      await _cartService.addToCart(userId, good.productID, 1);
      await loadCart(userId);
      await loadGoods();
      return;
    }
    existingGood.stock+=1;
    await _cartService.removeFromCart(userId, good.productID);
    await _cartService.addToCart(userId, existingGood.productID, existingGood.stock);
    await loadCart(userId);
    await loadGoods();
    notifyListeners();
  }

  Future<void> removeGood(Product good) async {
    final existingGood = _findGood(good.productID);
    if(existingGood.productID==-1){
      return;
    }
    existingGood.stock-=1;
    if(existingGood.stock <= 0){
      await deleteGood(existingGood);
    }
    await _cartService.removeFromCart(userId, good.productID);
    await _cartService.addToCart(userId, existingGood.productID, existingGood.stock);
    await loadCart(userId);
    await loadGoods();
    notifyListeners();
  }
  Future<void> deleteGood(Product good) async {
    final existingGood = _findGood(good.productID);
    if(existingGood.productID==-1){
      return;
    }
    await _cartService.removeFromCart(userId, existingGood.productID);
    await loadCart(userId);
    await loadGoods();
    notifyListeners();
  }
  Product _findGood(int id) {
    return _goods.firstWhere(
      (item) => item.productID == id,
      orElse: () => new Product(productID: -1, name: '', description: '', price: 0, stock: 0, imageURL: ''),
    );
  }
  bool findGood(int id) {
    return _goods.any((item) => item.productID == id);
  }
  int get totalPrice {
    return _goods.fold(0, (sum, item) {
      final price = item.price ?? 0;
      return sum + (price * item.stock).toInt();
    });
  }
}
