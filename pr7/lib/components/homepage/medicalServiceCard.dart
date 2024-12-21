import 'package:flutter/material.dart';
import 'package:pr7/components/homepage/addToCartButton.dart';
import 'package:pr7/components/homepage/medicalServiceInfo.dart';
import 'package:pr7/models/medicalService.dart';

class MedicalServiceCard extends StatelessWidget {
  final MedicalService service;

  const MedicalServiceCard({super.key, required this.service});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.grey.shade300,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: MedicalServiceInfo(service: service),
          ),
          AddToCartButton(service: service),
        ],
      ),
    );
  }
}