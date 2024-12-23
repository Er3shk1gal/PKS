import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pr8/models/product.dart';
import 'package:pr8/providers/product_service.dart';

class Goods extends ChangeNotifier {
  List<Product> _goods = [];
  late ProductsService _productsService = ProductsService(Dio());
  List<Product> get goods => List.unmodifiable(_goods);
  int userId;
  Goods({required this.userId});
  Future<void> loadGoods() async
  {
    var products = await _productsService.getProducts();
    _goods = products;
    notifyListeners();
  }
  Future<void> addGood(Product good) async {
    final existingGood = _findGood(good.productID);

    if(existingGood.productID!=-1){
      return;
    }
    await _productsService.createProduct(good);
    loadGoods();
    notifyListeners();
  }

  Future<void> removeGood(Product good)  async {
    final existingGood = _findGood(good.productID);
    if(existingGood.productID==-1){
      return;
    }
    await _productsService.deleteProduct(existingGood.productID);
    notifyListeners();
  }
  Future<void> updateGood(Product good)  async {
    final existingGood = _findGood(good.productID);
    if(existingGood.productID==-1){
      return;
    }
    await _productsService.updateProduct(good);
    notifyListeners();
  }
  Product _findGood(int id) {
    return _goods.firstWhere(
      (item) => item.productID == id,
      orElse: () => new Product(productID: -1, name: '', description: '', price: 0, stock: 0, imageURL: ''),
    );
  }
}