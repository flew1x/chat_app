import 'package:firebase_auth/firebase_auth.dart' show FirebaseAuth;
import 'package:flutter/cupertino.dart';

class SignHelper extends StatelessWidget {
  const SignHelper({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  void signOut() => FirebaseAuth.instance.signOut();

  void signIn(
      TextEditingController email, TextEditingController password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email.text, password: password.text);
  }
}
