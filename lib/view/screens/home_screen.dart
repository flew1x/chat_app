import 'dart:developer';
import 'package:chat_app/cotrollers/firebase_controller.dart';
import 'package:chat_app/services/firebase_helper.dart';
import 'package:chat_app/view/pages/contacts_page.dart';
import 'package:chat_app/view/pages/home_page.dart';
import 'package:chat_app/view/pages/messages_page.dart';
import 'package:chat_app/view/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

import '../../model/user_data.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeScreenState(),
    );
  }
}

class HomeScreenState extends ConsumerStatefulWidget {
  HomeScreenState({super.key});

  UserModel? user;

  @override
  ConsumerState<HomeScreenState> createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends ConsumerState<HomeScreenState> {
  int _indexOfPage = 0;
  final titlesOfPage = ['Главная', 'Сообщения', 'Контакты', 'Настройки'];
  final pages = [
    const HomePage(),
    const MessagesPage(),
    const ContactsPage(),
    const SettingsPage()
  ];

  void initUser() async {
    widget.user =
        await ref.read(firebaseControllerProvider).getCurrentUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: Center(child: pages[_indexOfPage]),
      appBar: _appBar(),
    );
  }

  _bottomNavBar() {
    return Container(
      color: const Color.fromARGB(59, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
            tabBackgroundColor: Colors.grey.shade800,
            backgroundColor: Colors.transparent,
            gap: 8,
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            onTabChange: (index) => setState(() {
                  initUser();
                  _indexOfPage = index;
                }),
            activeColor: Colors.white,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Главная',
              ),
              GButton(
                icon: Icons.messenger_outline_outlined,
                text: 'Сообщения',
              ),
              GButton(
                icon: Icons.contact_page_outlined,
                text: 'Контакты',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Настройки',
              ),
            ]),
      ),
    );
  }

  _appBar() {
    return AppBar(
      backgroundColor: Colors.black12,
      elevation: 0,
      title: Text(titlesOfPage[_indexOfPage]),
      leading: const Padding(
          padding: EdgeInsets.only(left: 20),
          child: CircleAvatar(
            backgroundColor: Colors.white,
          )),
    );
  }
}
