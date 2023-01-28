import 'dart:developer';
import 'dart:io';
import 'package:chat_app/cotrollers/firebase_controller.dart';
import 'package:chat_app/view/screens/screens.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/services/firebase_helper.dart';
import 'package:chat_app/view/screens/start_screen.dart';
import 'package:chat_app/view/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  File? imagefile;

  void selectImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    imagefile = File(image!.path);
    setState(() {});
    log(image.toString());
  }

  void signOut() {
    ref.read(firebaseControllerProvider).signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        children: [
          Container(
              width: double.infinity,
              height: 130,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(90, 255, 255, 255),
                          width: 0.5))),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Stack(
                    children: [
                      image == null
                          ? const CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'),
                              radius: 50,
                            )
                          : CircleAvatar(
                              backgroundImage: FileImage(imagefile!),
                              radius: 50,
                            ),
                      IconButton(
                        onPressed: selectImage,
                        icon: const Icon(
                          Icons.add_a_photo,
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          "Vlad",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 25),
                        ),
                      ],
                    ),
                  )
                ],
              )),
          const SizedBox(
            height: 20,
          ),
          Button(
              text: "Выйти",
              onPressed: () {
                FirebaseAuth.instance.authStateChanges().listen((User? user) {
                  if (user != null) {
                    signOut();
                    Get.off(() => const StartScreen());
                    log('User is currently signed out!');
                  } else {
                    log('User is signed in!');
                  }
                });
              },
              lightTheme: true)
        ],
      ),
    );
  }
}
