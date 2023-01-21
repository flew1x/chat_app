import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;
import 'package:flutter/material.dart';

class SignHelper extends StatelessWidget {
  const SignHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void signOut() => FirebaseAuth.instance.signOut();

  void signIn(
      TextEditingController email, TextEditingController password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }
}
