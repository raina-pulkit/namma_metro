import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_metro/Templates/bottom_nav_bar.dart';
import 'package:namma_metro/Templates/tickets2.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

void main() => runApp(const PersistentNavBar());

class PersistentNavBar extends StatefulWidget {
  const PersistentNavBar({super.key});

  @override
  State<PersistentNavBar> createState() => _PersistentNavBarState();
}

class _PersistentNavBarState extends State<PersistentNavBar> {
  // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    final tabCtr = PersistentTabController(
      initialIndex: 1,
    );

    final List<Widget> screens = [
      Builder(
        builder: (context) {
          return const Text("Home");
        }
      ),
      Builder(
        builder: (context) {
          return Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: ElevatedButton(
                onPressed: () async {
                  await PersistentNavBarNavigator.pushNewScreen(
                    context,
                    screen: const Ticket(),
                  );
                },
                child: const Text("Tickets")
              ),
            ),
          );
        }
      ),
      Builder(
        builder: (context) {
          return const Text("Profile");
        }
      ),
    ];

    final items = [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home, color: Colors.white,),
        inactiveIcon: const Icon(Icons.home, color: Color.fromRGBO(30, 30, 30, 1)),
        title: "Home",
        activeColorPrimary: CupertinoColors.white,
        // onPressed: () {
        //   PersistentNavBarNavigator.pushNewScreen(context, screen: Ticket());
        // }
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.airplane_ticket, color: Colors.white,),
        inactiveIcon: const Icon(Icons.airplane_ticket, color: Color.fromRGBO(30, 30, 30, 1)),
        title: "Tickets",
        activeColorPrimary: CupertinoColors.white,
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_circle, color: Colors.white,),
        inactiveIcon: const Icon(Icons.account_circle, color: Color.fromRGBO(30, 30, 30, 1)),
        title: "Profile",
        activeColorPrimary: CupertinoColors.white,
      ),

    ];

    return MaterialApp(
      home: PersistentTabView(
        context,
        controller: tabCtr,
        screens: screens,
        confineInSafeArea: true,
        handleAndroidBackButtonPress: true,
        navBarHeight: 60,
        resizeToAvoidBottomInset: true,
        hideNavigationBarWhenKeyboardShows: true,
        items: items,
        decoration: NavBarDecoration(
          gradient: lgBtm(),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(0)),
        ),
        onItemSelected: (int){
          setState(() {});
        },
        popAllScreensOnTapOfSelectedTab: true,
        popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}