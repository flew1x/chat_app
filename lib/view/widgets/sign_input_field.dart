import 'dart:math';

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final bool isRegistration;
  final bool isLogin;
  final TextEditingController textController;

  const InputField(
      {Key? key,
      required this.hint,
      required this.isPassword,
      required this.textController,
      this.isRegistration = false,
      this.isLogin = false})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      width: double.infinity,
      height: 55,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: TextFormField(
                  validator: isPassword ? validatePassword : validateEmail,
                  controller: textController,
                  autofocus: false,
                  cursorColor: const Color.fromARGB(255, 0, 0, 0),
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.black),
                  obscureText: isPassword,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                  decoration: InputDecoration(
                      hintText: hint,
                      hintStyle: const TextStyle(color: Colors.black),
                      focusedBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0)),
                      enabledBorder: const UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.transparent, width: 0))),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value) && !isLogin
        ? 'Введите правильную почту'
        : null;
  }

  String? validatePassword(String? value) {
    const pattern = r'.{6,}$';
    final regex = RegExp(pattern);

    return value!.isNotEmpty &&
            !regex.hasMatch(value) &&
            isRegistration &&
            !isLogin
        ? 'Пароль должен быть не меньше 6 символов'
        : null;
  }
}
