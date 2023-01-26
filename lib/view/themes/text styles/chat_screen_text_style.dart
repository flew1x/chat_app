import 'package:chat_app/view/themes/theme.dart';
import 'package:flutter/material.dart';

TextStyle get messagesTextStyle {
  return const TextStyle(fontSize: 15, color: Colors.white);
}

TextStyle get statusOnlineTextStyle {
  return const TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.bold,
    color: Colors.green,
  );
}

TextStyle get nameTextStyle {
  return const TextStyle(fontSize: 16);
}

TextStyle get timeOfMessageTextStyle {
  return const TextStyle(
      color: AppColors.textFaded, fontSize: 10, fontWeight: FontWeight.bold);
}
