import 'package:flutter/material.dart';
import 'package:pr6/models/good.dart';

class Cart extends ChangeNotifier {
  final List<Good> _goods = [];

  List<Good> get goods => _goods;

  void addGood(Good good) {
    final existingGood = _findGood(good.title);

    if (existingGood.title=='') {
      _goods.add(Good(
        title: good.title,
        price: good.price,
        content: good.content,
        filePath: good.filePath,
        id: _goods.length,
      ));
    } else {
      existingGood.amount++;
    }

    notifyListeners();
  }

  void removeGood(Good good) {
    final existingGood = _findGood(good.title);

    if ( existingGood.amount > 0) {
      existingGood.amount--;
      if (existingGood.amount == 0) {
        _goods.remove(existingGood);
      }
    }

    notifyListeners();
  }
  void deleteGood(Good good) {
    final existingGood = _findGood(good.title);
    _goods.remove(existingGood);
    notifyListeners();
  }
  Good _findGood(String title) {
    return _goods.firstWhere(
      (item) => item.title == title,
      orElse: () => new Good(title: '', price: 0, id:-1,content: ""),
    );
  }

  int get totalPrice {
    return _goods.fold(0, (sum, item) {
      final price = item.price ?? 0;
      return sum + (price * item.amount).toInt();
    });
  }
}
