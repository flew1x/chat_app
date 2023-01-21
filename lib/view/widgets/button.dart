import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool lightTheme;

  const Button(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.lightTheme})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: lightTheme
              ? const Color.fromARGB(255, 202, 202, 202)
              : const Color.fromARGB(255, 0, 172, 66),
          fixedSize: const Size(345, 55),
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(Radius.circular(20)),
              side: BorderSide(
                  color: lightTheme
                      ? const Color.fromARGB(255, 51, 51, 51)
                      : const Color.fromARGB(255, 223, 223, 223)))),
      child: Text(
        text,
        style: TextStyle(
            fontSize: 17,
            color: lightTheme
                ? const Color.fromARGB(255, 58, 58, 58)
                : const Color.fromARGB(255, 255, 255, 255)),
      ),
    );
  }
}
