import 'package:chat_app/view/screens/login_screen.dart';
import 'package:chat_app/view/screens/sign_up_screen.dart';
import 'package:chat_app/view/widgets/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(
                Icons.chat_bubble_outline_outlined,
                size: 200,
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                "Общайтесь с друзьями и родственниками в один клик",
                style: TextStyle(fontSize: 20),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 60,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Button(
                      text: "Войти",
                      onPressed: () {
                        Get.to(() => const LoginScreen(),
                            transition: Transition.rightToLeft);
                      },
                      lightTheme: false),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Button(
                  text: "Зарегестрироваться",
                  onPressed: () {
                    Get.to(() => const SignUpScreen(),
                        transition: Transition.leftToRight);
                  },
                  lightTheme: true)
            ]),
      ),
    );
  }
}
