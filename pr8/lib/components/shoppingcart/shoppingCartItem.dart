import 'package:flutter/material.dart';
import 'package:pr8/components/shoppingcart/shoppingCartItemActions.dart';
import 'package:pr8/components/shoppingcart/shoppingCartItemDetails.dart';
import 'package:pr8/models/cart.dart';
import 'package:pr8/models/product.dart';
import 'package:pr8/models/shoppingcart.dart';
import 'package:provider/provider.dart';

class ShoppingCartItem extends StatelessWidget {
  final Product good;

  const ShoppingCartItem(this.good, {super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ShoppingCart>(context);
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
