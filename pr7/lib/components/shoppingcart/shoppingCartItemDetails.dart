import 'package:flutter/material.dart';
import 'package:pr7/models/medicalService.dart';

class ShoppingCartItemDetails extends StatelessWidget {
  final MedicalService service;

  const ShoppingCartItemDetails({required this.service, super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service.title,
          style: const TextStyle(fontFamily: 'Montserrat', fontSize: 18),
        ),
        Text(
          'Цена: ${service.price}',
          style: const TextStyle(fontFamily: 'Montserrat'),
        ),
        Text(
          'Пациент: ${service.amount}',
          style: const TextStyle(fontFamily: 'Montserrat'),
        ),
      ],
    );
  }
}