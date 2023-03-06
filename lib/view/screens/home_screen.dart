import 'dart:developer';
import 'package:chat_app/cotrollers/firebase_controller.dart';
import 'package:chat_app/view/pages/home_page.dart';
import 'package:chat_app/view/pages/messages_page.dart';
import 'package:chat_app/view/pages/settings_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../../models/user_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeScreenState(),
    );
  }
}

class HomeScreenState extends ConsumerStatefulWidget {
  const HomeScreenState({super.key});

  @override
  ConsumerState<HomeScreenState> createState() => _HomeScreenStateState();
}

class _HomeScreenStateState extends ConsumerState<HomeScreenState> {
  var _currentIndex = 0;
  UserModel? user;
  final _titlesOfPage = ['Главная', 'Сообщения', 'Настройки'];

  void onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void initUser() async {
    user = await ref.read(firebaseControllerProvider).getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bottomNavBar(),
      appBar: _appBar(),
    );
  }

  _appBar() {
    return ref.watch(userDataProvider).when(
          data: (user) {
            return AppBar(
                backgroundColor: Colors.black12,
                elevation: 0,
                title: Text(_titlesOfPage[_currentIndex]),
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

  late final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0);

  List<Widget> _buildScreens() {
    return [const HomePage(), const MessagePage(), const SettingsPage()];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Домашняя"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.chat_bubble),
        title: ("Сообщения"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.settings),
        title: ("Настройки"),
        activeColorPrimary: CupertinoColors.white,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  _bottomNavBar() {
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.transparent,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardShows: true,
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.transparent,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        duration: Duration(milliseconds: 100),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        animateTabTransition: false,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle: NavBarStyle.style12,
    );
  }
}
