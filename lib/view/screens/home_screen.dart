import 'dart:developer';
import 'package:chat_app/cotrollers/firebase_controller.dart';
import 'package:chat_app/view/pages/home_page.dart';
import 'package:chat_app/view/pages/messages_page.dart';
import 'package:chat_app/view/pages/settings_page.dart';
import 'package:chat_app/view/widgets/loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../model/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenState(),
    );
  }
}

@immutable
class HomeScreenState extends ConsumerStatefulWidget {
  HomeScreenState({super.key});

  UserModel? user;

  @override
  ConsumerState<HomeScreenState> createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends ConsumerState<HomeScreenState> {
  var _currentIndex = 0;

  final titlesOfPage = ['Главная', 'Сообщения', 'Настройки'];
  final pages = [const HomePage(), const MessagePage(), const SettingsPage()];

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void initUser() async {
    widget.user =
        await ref.read(firebaseControllerProvider).getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: Center(child: pages[_currentIndex]),
      appBar: _appBar(),
    );
  }

  _bottomNavBar() {
    return BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        onTap: onTap,
        iconSize: 30,
        currentIndex: _currentIndex,
        unselectedItemColor: Colors.grey.withOpacity(0.5),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        elevation: 0,
        items: const [
          BottomNavigationBarItem(
              label: "Домашняя", icon: Icon(Icons.home_filled)),
          BottomNavigationBarItem(
              label: "Сообщения", icon: Icon(Icons.message_rounded)),
          BottomNavigationBarItem(
              label: "Настройки", icon: Icon(Icons.settings)),
        ]);
  }

  _appBar() {
    return ref.watch(userDataProvider).when(
          data: (user) {
            return AppBar(
                backgroundColor: Colors.black12,
                elevation: 0,
                title: Text(titlesOfPage[_currentIndex]),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: user?.profileAvatar == null
                      ? const CircleAvatar(
                          backgroundImage: NetworkImage(
                              'https://png.pngitem.com/pimgs/s/649-6490124_katie-notopoulos-katienotopoulos-i-write-about-tech-round.png'),
                          radius: 50,
                        )
                      : CircleAvatar(
                          backgroundImage: NetworkImage(user!.profileAvatar),
                          radius: 50,
                        ),
                ));
          },
          error: (err, track) {
            log(err.toString());
          },
          loading: () {},
        );
  }
}
