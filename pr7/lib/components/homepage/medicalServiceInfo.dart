import 'package:flutter/material.dart';
import 'package:pr7/models/medicalService.dart';

class MedicalServiceInfo extends StatelessWidget {
  final MedicalService service;

  const MedicalServiceInfo({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          service.title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            fontFamily: 'Montserrat',
          ),
        ),
        const SizedBox(height: 4),
        Text(
          service.duration,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            fontFamily: 'Montserrat',
          ),
        ),
        Text(
          service.price,
          style: const TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
          ),
        ),
      ],
    );
  }
}
