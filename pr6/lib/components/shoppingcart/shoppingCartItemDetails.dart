import 'package:flutter/material.dart';
import 'package:pr6/models/good.dart';

class ShoppingCartItemDetails extends StatelessWidget {
  final Good good;

  const ShoppingCartItemDetails({required this.good, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.network(
            good.filePath!,
            width: double.infinity,
            height: 100,
            fit: BoxFit.cover,
          ),
        Text(
          good.title
        ),
        Text(
          'Price: ${good.price}'
        ),
        Text(
          'Amount: ${good.amount}'
        ),
      ],
    );
  }
}