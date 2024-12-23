import 'package:flutter/material.dart';
import 'package:pr8/models/cart.dart';
import 'package:pr8/models/product.dart';
import 'package:pr8/models/shoppingcart.dart';
import 'package:provider/provider.dart';

class ShoppingCartItemActions extends StatelessWidget {
  final Product good;

  const ShoppingCartItemActions({required this.good, super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ShoppingCart>(context);
    return  Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            cart.removeGood(good);// Обновление состояния после удаления
          },
        ),
        Text('${cart.goods.firstWhere((item) => item.productID == good.productID).stock}'),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            cart.addGood(good); // Обновление состояния после добавления
          },
        ),
        IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            cart.deleteGood(good); // Обновление состояния после добавления
          },
        ),
      ],
    );
  }
}