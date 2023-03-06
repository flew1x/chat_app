import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final bool lightTheme;
  final Color btnClr;

  const DefaultButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      required this.lightTheme,
      required this.btnClr})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
          backgroundColor: btnClr,
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
