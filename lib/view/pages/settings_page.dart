import 'dart:developer';

import 'package:chat_app/model/signHelper.dart';
import 'package:chat_app/view/screens/start_screen.dart';
import 'package:chat_app/view/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final signHelper = const SignHelper();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
            text: "Выйти",
            onPressed: () {
              FirebaseAuth.instance.authStateChanges().listen((User? user) {
                if (user == null) {
                  Get.off(() => const StartScreen());
                  log('User is currently signed out!');
                } else {
                  log('User is signed in!');
                }
              });

              signHelper.signOut();
            },
            lightTheme: true)
      ],
    );
  }
}
