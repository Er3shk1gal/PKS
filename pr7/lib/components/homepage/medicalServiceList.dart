import 'package:flutter/material.dart';
import 'package:pr7/components/homepage/medicalServiceCard.dart';
import 'package:pr7/models/medicalService.dart';

class MedicalServiceList extends StatelessWidget {
  const MedicalServiceList({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      MedicalService(title: 'Клинический анализ крови с лейкоцитарной формулой', price: '690 ₽', duration: '1 день'),
      MedicalService(title: 'ПЦР-тест на определение РНК коронавируса', price: '1800 ₽', duration: '2 дня'),
      MedicalService(title: 'Глюкозотолерантный тест с определением глюкозы и С-пептида в венозной крови натощак и через 2 часа после углеводной нагрузки', price: '1 400 ₽', duration: '1 день'),
      MedicalService(title: 'Электрофорез гемоглобина', price: '4 265 ₽', duration: '7 дней'),
      MedicalService(title: 'Респираторная панель Immulite (20 респираторных аллергенов)', price: '8 650 ₽', duration: '5 дней'),
      MedicalService(title: 'Антитела к ВИЧ 1 и 2 и антиген ВИЧ 1 и 2', price: '620 ₽', duration: '1 день'),
      MedicalService(title: 'Антитела класса IgM к Respiratory syncyt. vir.', price: '1 150 ₽', duration: '5 дней'),
    ];

    return ListView.builder(
      padding: const EdgeInsets.all(12),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
        return MedicalServiceCard(service: service);
      },
    );
  }
}