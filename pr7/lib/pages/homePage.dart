import 'package:flutter/material.dart';
import 'package:pr7/components/homepage/medicalServiceList.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Каталог услуг',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            fontFamily: 'Montserrat',
          ),
        ),
      ),
      body: const MedicalServiceList(),
    );
  }
}
