import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chat_app/cotrollers/firebase_controller.dart';
import 'package:chat_app/view/themes/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import '../widgets/default_button.dart';
import '../widgets/sign_input_field.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({super.key});

  @override
  ConsumerState<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends ConsumerState<SignUpPage> {
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30, left: 30, right: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
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
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                _subtitleText,
                style: const TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 12,
              ),
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SignInputField(
                    textController: _loginController,
                    hint: "Логин",
                    isPassword: false,
                    isRegistration: true,
                    isLogin: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SignInputField(
                    textController: _emailController,
                    hint: "Почта",
                    isPassword: false,
                    isRegistration: false,
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
                  SignInputField(
                    textController: _passwordController,
                    hint: "Пароль",
                    isPassword: true,
                    isRegistration: true,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SignInputField(
                    textController: _repeatPasswordController,
                    hint: "Повторите пароль",
                    isRegistration: true,
                    isPassword: true,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 120),
                child: DefaultButton(
                  btnClr: AppColors.greenBtn,
                  text: "Зарегистрироваться",
                  onPressed: () {
                    ref
                        .read(firebaseControllerProvider)
                        .signUp(_emailController, _passwordController, context);
                    ref
                        .read(firebaseControllerProvider)
                        .signIn(_emailController, _passwordController, context);
                  },
                  lightTheme: false,
                ),
              )
            ],
          ),
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
