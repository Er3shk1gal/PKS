import 'package:flutter/material.dart';
import 'package:pr8/components/shoppingcart/checkoutButton.dart';
import 'package:pr8/components/shoppingcart/emptyShoppingCartMessage.dart';
import 'package:pr8/components/shoppingcart/shoppingCartItemList.dart';
import 'package:pr8/components/shoppingcart/totalPrice.dart';
import 'package:pr8/models/cart.dart';
import 'package:pr8/models/shoppingcart.dart';
import 'package:provider/provider.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ShoppingCart>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Корзина',
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
