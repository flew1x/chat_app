import 'package:chat_app/view/pages/calls_page.dart';
import 'package:chat_app/view/pages/contacts_page.dart';
import 'package:chat_app/view/pages/home_page.dart';
import 'package:chat_app/view/pages/messages_page.dart';
import 'package:chat_app/view/pages/notification_page.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  final pages = const [
    MessagesPage(),
    CallsPage(),
    NotificationPage(),
    ContactsPage(),
    HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(bottomNavigationBar: _bottomNavBar());
  }

  _bottomNavBar() {
    return Container(
      color: Colors.black,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
        child: GNav(
            tabBackgroundColor: Colors.grey.shade800,
            backgroundColor: Colors.black,
            gap: 8,
            color: Colors.white,
            padding: const EdgeInsets.all(15),
            onTabChange: (index) => pages[index],
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
