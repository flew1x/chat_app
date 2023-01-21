import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/button.dart';
import '../widgets/input_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final String _titleText = 'ПРИВЕТ';
  final String _subtitleText = 'Здравcтвуйте, войдите в свой аккаунт';

  TextEditingController loginTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AnimatedTextKit(
                      animatedTexts: [
                        WavyAnimatedText(_titleText,
                            speed: const Duration(milliseconds: 200),
                            textStyle: const TextStyle(
                                fontSize: 50,
                                color: Colors.limeAccent,
                                fontWeight: FontWeight.bold)),
                      ],
                      isRepeatingAnimation: false,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: 350,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          _subtitleText,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 15,
                              color: Color.fromARGB(255, 168, 168, 168)),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 35, left: 35),
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        textController: loginTextController,
                        isPassword: false,
                        hint: 'Логин',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        hint: "Пароль",
                        textController: passwordTextController,
                        isPassword: true,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 100),
                  child: Button(
                    text: "Войти",
                    onPressed: (() {}),
                    lightTheme: false,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: context.theme.backgroundColor,
      elevation: 0,
      leading: GestureDetector(
        onTap: () => Get.back(),
        child: const Icon(
          Icons.arrow_back_ios_new,
          color: Color.fromARGB(255, 255, 255, 255),
          size: 20,
        ),
      ),
    );
  }
}
