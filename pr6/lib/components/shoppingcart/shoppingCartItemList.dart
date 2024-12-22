import 'package:flutter/material.dart';
import 'package:pr6/components/shoppingcart/shoppingCartItem.dart';
import 'package:pr6/models/cart.dart';

class ShoppingCartItemList extends StatelessWidget {
  final Cart shoppingCart;

  const ShoppingCartItemList({required this.shoppingCart, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shoppingCart.goods.length,
      itemBuilder: (context, index) {
        return ShoppingCartItem(shoppingCart.goods[index]);
      },
    );
  }
}