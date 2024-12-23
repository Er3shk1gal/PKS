import 'package:flutter/material.dart';
import 'package:pr8/components/shoppingcart/shoppingCartItem.dart';
import 'package:pr8/models/cart.dart';
import 'package:pr8/models/shoppingcart.dart';

class ShoppingCartItemList extends StatelessWidget {
  final ShoppingCart shoppingCart;

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