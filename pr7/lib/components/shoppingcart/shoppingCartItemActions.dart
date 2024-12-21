import 'package:flutter/material.dart';
import 'package:pr7/models/medicalService.dart';
import 'package:pr7/models/shoppingCart.dart';
import 'package:provider/provider.dart';

class ShoppingCartItemActions extends StatelessWidget {
  final MedicalService service;

  const ShoppingCartItemActions({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<ShoppingCart>(context);
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.remove),
          onPressed: () {
            cart.removeService(service);
          },
        ),
        IconButton(
          icon: const Icon(Icons.add),
          onPressed: () {
            cart.addService(service);
          },
        ),
      ],
    );
  }
}