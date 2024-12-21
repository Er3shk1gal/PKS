import 'package:flutter/material.dart';
import 'package:pr7/components/shoppingcart/shoppingCartItemActions.dart';
import 'package:pr7/components/shoppingcart/shoppingCartItemDetails.dart';
import 'package:pr7/models/medicalService.dart';
import 'package:pr7/models/shoppingCart.dart';
import 'package:provider/provider.dart';

class ShoppingCartItem extends StatelessWidget {
  final MedicalService service;

  const ShoppingCartItem(this.service, {super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ShoppingCart>(context);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: ShoppingCartItemDetails(service: service),
          ),
          ShoppingCartItemActions(service: service),
        ],
      ),
    );
  }
}
