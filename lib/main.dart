import 'dart:developer';
import 'package:chat_app/cotrollers/firebase_controller.dart';
import 'package:chat_app/firebase_options.dart';
import 'package:chat_app/view/screens/home_screen.dart';
import 'package:chat_app/view/screens/start_screen.dart';
import 'package:chat_app/view/themes/theme.dart';
import 'package:chat_app/view/widgets/loader.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GetMaterialApp(
      theme: AppTheme().dark,
      home: ref.watch(userDataProvider).when(
            data: (user) {
              if (user == null) {
                return const StartScreen();
              }
              return const HomeScreen();
            },
            error: (err, trace) {
              log(err.toString());
              return;
            },
            loading: () => const Loader(),
          ),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
    );
  }
}
