import 'package:flutter/material.dart';
import 'package:pr6/components/shoppingcart/shoppingCartItemActions.dart';
import 'package:pr6/components/shoppingcart/shoppingCartItemDetails.dart';
import 'package:pr6/models/cart.dart';
import 'package:pr6/models/good.dart';
import 'package:provider/provider.dart';

class ShoppingCartItem extends StatelessWidget {
  final Good good;

  const ShoppingCartItem(this.good, {super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ShoppingCartItemDetails(good: good),
          ),
          ShoppingCartItemActions(good: good),
        ],
      ),
    );
  }
}
