import 'package:flutter/material.dart';
import 'package:pr6/components/shoppingcart/checkoutButton.dart';
import 'package:pr6/components/shoppingcart/emptyShoppingCartMessage.dart';
import 'package:pr6/components/shoppingcart/shoppingCartItemList.dart';
import 'package:pr6/components/shoppingcart/totalPrice.dart';
import 'package:pr6/models/cart.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: cart.goods.isEmpty
            ? const EmptyShoppingCartMessage()
            : Column(
                children: [
                  Expanded(
                    child: ShoppingCartItemList(shoppingCart: cart),
                  ),
                  const SizedBox(height: 16),
                  TotalPrice(totalPrice: cart.totalPrice.toDouble()), // Преобразование в double
                  const SizedBox(height: 16),
                  CheckoutButton(),
                ],
              ),
      ),
    );
  }
}
