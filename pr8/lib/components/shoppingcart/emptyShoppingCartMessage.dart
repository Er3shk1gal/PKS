import 'package:flutter/material.dart';

class EmptyShoppingCartMessage extends StatelessWidget {
  const EmptyShoppingCartMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Cart empty'
      ),
    );
  }
}