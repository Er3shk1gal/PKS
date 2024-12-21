import 'package:flutter/material.dart';

class TotalPrice extends StatelessWidget {
  final double totalPrice;

  const TotalPrice({required this.totalPrice, super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Сумма: $totalPrice ₽',
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    );
  }
}
