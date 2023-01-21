import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final bool isPassword;
  final TextEditingController textController;

  const InputField(
      {Key? key,
      required this.hint,
      required this.isPassword,
      required this.textController})
      : super(key: key);

  @override
  Widget build(
    BuildContext context,
  ) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 255, 255, 255),
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(10)),
      width: 350,
      height: 55,
      child: Column(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                controller: textController,
                autofocus: false,
                cursorColor: const Color.fromARGB(255, 0, 0, 0),
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.black),
                obscureText: isPassword,
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
            ],
          ),
        ],
      ),
    );
  }
}
