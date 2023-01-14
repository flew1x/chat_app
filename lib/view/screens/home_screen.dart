import 'package:chat_app/view/pages/contacts_page.dart';
import 'package:chat_app/view/pages/home_page.dart';
import 'package:chat_app/view/pages/messages_page.dart';
import 'package:chat_app/view/pages/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreenState(),
    );
  }
}

class HomeScreenState extends StatefulWidget {
  const HomeScreenState({super.key});

  @override
  State<HomeScreenState> createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends State<HomeScreenState> {
  int _indexOfPage = 0;
  final pages = const [
    HomePage(),
    MessagesPage(),
    ContactsPage(),
    SettingsPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _bottomNavBar(),
      body: Center(child: pages[_indexOfPage]),
    );
  }

  _bottomNavBar() {
    return Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
            tabBackgroundColor: Colors.grey.shade800,
            backgroundColor: Colors.transparent,
            gap: 8,
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            onTabChange: (index) => setState(() {
                  _indexOfPage = index;
                  print(index);
                }),
            activeColor: Colors.white,
            tabs: const [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.messenger_outline_outlined,
                text: 'Messages',
              ),
              GButton(
                icon: Icons.contact_page_outlined,
                text: 'Contacts',
              ),
              GButton(
                icon: Icons.settings,
                text: 'Settings',
              ),
            ]),
      ),
    );
  }
}
