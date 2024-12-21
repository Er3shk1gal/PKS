import 'package:flutter/material.dart';
import 'package:pr7/models/medicalService.dart';
import 'package:pr7/models/shoppingCart.dart';
import 'package:provider/provider.dart';

class AddToCartButton extends StatelessWidget {
  final MedicalService service;

  const AddToCartButton({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final cart = Provider.of<ShoppingCart>(context, listen: false);
        cart.addService(service);
      },
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Text(
          'Добавить',
          style: TextStyle(fontFamily: 'Montserrat'),
        ),
      ),
    );
  }
}