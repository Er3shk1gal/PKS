import 'package:flutter/material.dart';
import 'package:pr7/components/profilepage/profileOption.dart';

class ProfileOptions extends StatelessWidget {
  const ProfileOptions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ProfileOption(iconPath: 'assets/icons/Order.png', title: 'Мои заказы'),
        ProfileOption(iconPath: 'assets/icons/Cards.png', title: 'Медицинские карты'),
        ProfileOption(iconPath: 'assets/icons/Adress.png', title: 'Мои адреса'),
        ProfileOption(iconPath: 'assets/icons/Settings.png', title: 'Настройки'),
      ],
    );
  }
}
