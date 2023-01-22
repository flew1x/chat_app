import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/model/signHelper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/button.dart';
import '../widgets/sign_input_field.dart';

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

  final signHelper = const SignHelper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: Column(
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
                  Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        textController: loginTextController,
                        isPassword: false,
                        isRegistration: false,
                        hint: 'Почта',
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      InputField(
                        hint: "Пароль",
                        isRegistration: false,
                        textController: passwordTextController,
                        isPassword: true,
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Button(
                      text: "Войти",
                      onPressed: (() {
                        signHelper.signIn(
                            loginTextController, passwordTextController);
                      }),
                      lightTheme: false,
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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
