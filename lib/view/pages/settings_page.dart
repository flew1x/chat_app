import 'package:chat_app/model/signHelper.dart';
import 'package:chat_app/view/widgets/button.dart';
import 'package:flutter/widgets.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  final signHelper = const SignHelper();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Button(
            text: "Выйти",
            onPressed: () {
              signHelper.signOut();
            },
            lightTheme: true)
      ],
    );
  }
}
