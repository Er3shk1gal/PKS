import 'package:flutter/material.dart';
import 'package:pr7/components/profilepage/profileLink.dart';

class ProfileLinks extends StatelessWidget {
  const ProfileLinks({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        ProfileLink(text: 'Ответы на вопросы'),
        ProfileLink(text: 'Политика конфиденциальности'),
        ProfileLink(text: 'Пользовательское соглашение'),
      ],
    );
  }
}