import 'dart:developer';
import 'dart:io';
import 'package:chat_app/cotrollers/firebase_controller.dart';
import 'package:chat_app/view/themes/theme.dart';
import 'package:chat_app/view/widgets/loader.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:chat_app/view/screens/start_screen.dart';
import 'package:chat_app/view/widgets/button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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

  void _selectImage() async {
    image = await _picker.pickImage(source: ImageSource.gallery);
    imagefile = File(image!.path);
    if (!mounted) return;
    ref
        .read(firebaseControllerProvider)
        .saveUserData(context, "Vlad", imagefile);
    log(imagefile.toString());
    DefaultCacheManager().emptyCache();
    imageCache.clear();
    imageCache.clearLiveImages();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(userDataProvider).when(
        data: (user) => Padding(
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
                              user?.profileAvatar == null
                                  ? const CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'),
                                      radius: 50,
                                    )
                                  : CircleAvatar(
                                      key: UniqueKey(),
                                      backgroundImage:
                                          NetworkImage(user!.profileAvatar),
                                      radius: 50,
                                    ),
                              IconButton(
                                onPressed: _selectImage,
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
                              children: [
                                Text(
                                  user?.name != null ? "Vlad" : "Star",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 25),
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
                      text: "Добавить в друзья",
                      onPressed: () {
                        _addFriendDialog(context);
                      },
                      lightTheme: false,
                      btnClr: AppColors.greenBtn),
                  const SizedBox(
                    height: 17,
                  ),
                  Button(
                      text: "Выйти",
                      onPressed: () {
                        FirebaseAuth.instance
                            .authStateChanges()
                            .listen((User? user) {
                          if (user != null) {
                            ref.read(firebaseControllerProvider).signOut();
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const StartScreen(),
                              ),
                              (route) => false,
                            );
                            log('User is currently signed out!');
                          } else {
                            log('User is signed in!');
                          }
                        });
                      },
                      btnClr: AppColors.lightBtn,
                      lightTheme: true),
                ],
              ),
            ),
        error: (err, trace) {
          log(err.toString());
          return const Loader();
        },
        loading: () {
          return const Loader();
        });
  }

  _addFriendDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: ((context, setState) {
            return AlertDialog(
              backgroundColor: AppColors.cardDark,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))),
              title: const Text(
                "Добавить в друзья",
                textAlign: TextAlign.left,
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.green),
                            borderRadius: BorderRadius.circular(20)),
                        errorBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.red),
                            borderRadius: BorderRadius.circular(20)),
                        focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(color: Colors.white),
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("Назад"),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text("Добавить"),
                ),
              ],
            );
          }));
        });
  }
}
