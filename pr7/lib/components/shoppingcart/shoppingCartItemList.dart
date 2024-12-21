import 'package:flutter/material.dart';
import 'package:pr7/components/shoppingcart/shoppingCartItem.dart';
import 'package:pr7/models/shoppingCart.dart';

class ShoppingCartItemList extends StatelessWidget {
  final ShoppingCart shoppingCart;

  const ShoppingCartItemList({required this.shoppingCart, super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: shoppingCart.services.length,
      itemBuilder: (context, index) {
        return ShoppingCartItem(shoppingCart.services[index]);
      },
    );
  }
}