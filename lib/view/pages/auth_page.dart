import 'package:chat_app/view/pages/home_page.dart';
import 'package:chat_app/view/pages/login_page.dart';
import 'package:chat_app/view/screens/home_screen.dart';
import 'package:chat_app/view/screens/start_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const StartScreen();
          }
        }),
      ),
    );
  }
}
