import 'dart:developer' show log;

import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException, User;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../view/screens/home_screen.dart';

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
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out!');
        } else {
          Get.off(() => const HomeScreen());
          log('User is signed in!');
        }
      });
    } on FirebaseAuthException catch (e) {
      log(e.code);
    }
  }

  void createUser(
      TextEditingController email, TextEditingController password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email.text, password: password.text);
      log("was created");
      signIn(email, password);
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          log('User is currently signed out!');
        } else {
          Get.off(() => const HomeScreen());
          log('User is signed in!');
        }
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        log('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        log('The account already exists for that email.');
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
