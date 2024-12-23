import 'package:flutter/material.dart';
import 'package:pr8/models/product.dart';

class ShoppingCartItemDetails extends StatelessWidget {
  final Product good;

  const ShoppingCartItemDetails({required this.good, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
            good.imageURL!,
            width: double.infinity,
            height: 100,
            fit: BoxFit.cover,
          ),
        Text(
          good.name
        ),
        Text(
          'Price: ${good.price}'
        ),
        Text(
          'Amount: ${good.stock}'
        ),
      ],
    );
  }
}