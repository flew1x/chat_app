import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/button.dart';
import '../widgets/input_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final String _titleText = 'Создайте свой аккаунт';
  final String _subtitleText = 'Это легко! Просто сделайте это!';

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _repeatPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Padding(
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
                    TypewriterAnimatedText(_titleText,
                        speed: const Duration(milliseconds: 100),
                        textStyle: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color: Colors.yellow)),
                  ],
                  isRepeatingAnimation: false,
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _subtitleText,
                  style: const TextStyle(fontSize: 20),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 35, left: 35),
              child: Column(
                children: [
                  const SizedBox(
                    height: 40,
                  ),
                  InputField(
                    textController: _loginController,
                    hint: "Логин",
                    isPassword: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    textController: _emailController,
                    hint: "Почта",
                    isPassword: false,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    thickness: 2,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    textController: _passwordController,
                    hint: "Пароль",
                    isPassword: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  InputField(
                    textController: _repeatPasswordController,
                    hint: "Повторите пароль",
                    isPassword: true,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 120),
              child: Button(
                text: "Зарегистрироваться",
                onPressed: () {},
                lightTheme: false,
              ),
            )
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
