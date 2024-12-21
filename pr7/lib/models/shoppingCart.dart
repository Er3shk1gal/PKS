import 'package:flutter/material.dart';
import 'medicalService.dart';

class ShoppingCart extends ChangeNotifier {
  final List<MedicalService> _services = [];

  List<MedicalService> get services => List.unmodifiable(_services);

  void addService(MedicalService service) {
    final existingService = _findService(service.title);

    if (existingService.title=='') {
      _services.add(MedicalService(
        title: service.title,
        price: service.price,
        duration: service.duration,
        amount: 1,
      ));
    } else {
      existingService.amount++;
    }

    notifyListeners();
  }

  void removeService(MedicalService service) {
    final existingService = _findService(service.title);

    if ( existingService.amount > 0) {
      existingService.amount--;
      if (existingService.amount == 0) {
        _services.remove(existingService);
      }
    }

    notifyListeners();
  }

  MedicalService _findService(String title) {
    return _services.firstWhere(
      (item) => item.title == title,
      orElse: () => new MedicalService(title: '', price: '', duration: '', amount: 0),
    );
  }

  int get totalPrice {
    return _services.fold(0, (sum, item) {
      final price = int.tryParse(item.price.replaceAll(' ₽', '').trim()) ?? 0;
      return sum + (price * item.amount).toInt();
    });
  }
}
