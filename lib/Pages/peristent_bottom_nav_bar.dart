import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:namma_metro/Pages/Profile_Menu/profile_menu.dart';
import 'package:namma_metro/Pages/Search/search_list.dart';
import 'package:namma_metro/Pages/Ticket_Booking/plan_your_journey.dart';
import 'package:namma_metro/Pages/tickets2.dart';
import 'package:namma_metro/Pages/Home/home.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'Contact_Us/contact_us.dart';

LinearGradient lgBtm() {
  return const LinearGradient(
    colors: <Color>[
      Color(0xff1f005c),
      Color(0xff5b0060),
      Color(0xff870160),
      Color(0xffac255e),
      Color(0xffca485c),
      Color(0xffe16b5c),
      Color(0xfff39060),
      Color(0xffffb56b),
    ],
  );
}


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
      initialIndex: 0,
    );

    final List<Widget> screens = [
      Builder(
        builder: (context) {
          return const HomePage();
        }
      ),
      Builder(
        builder: (context) {
          return const SearchList();
        }
      ),
      Builder(
        builder: (context) {
          return const PlanYourJourney(show: false,);
        }
      ),
      Builder(
          builder: (context) {
            return const ProfileMenu();
          }
      ),
      Builder(
          builder: (context) {
            return const ContactPage(show: false,);
          }
      ),
    ];

    final items = [
      PersistentBottomNavBarItem(
        icon: const Icon(Icons.home, color: Color.fromRGBO(0, 153, 76, 1)),
        inactiveIcon: const Icon(Icons.home, color: Colors.white,),
        title: "Home",
        textStyle: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700
        ),
        activeColorPrimary: CupertinoColors.systemTeal,
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.search, color: Color.fromRGBO(0, 153, 76, 1),),
        inactiveIcon: const Icon(Icons.search, color: Colors.white),
        title: "Search",
        textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700
        ),
        activeColorPrimary: CupertinoColors.systemTeal,
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.airplane_ticket, color: Color.fromRGBO(0, 153, 76, 1),),
        inactiveIcon: const Icon(Icons.airplane_ticket, color: Colors.white),
        title: "Tickets",
        textStyle: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700
        ),
        activeColorPrimary: CupertinoColors.systemTeal,
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.account_circle, color: Color.fromRGBO(0, 153, 76, 1),),
        inactiveIcon: const Icon(Icons.account_circle, color: Colors.white),
        title: "Profile",
        textStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w700
        ),
        activeColorPrimary: CupertinoColors.systemTeal,
      ),

      PersistentBottomNavBarItem(
        icon: const Icon(Icons.phone, color: Color.fromRGBO(0, 153, 76, 1),),
        inactiveIcon: const Icon(Icons.phone, color: Colors.white),
        title: "Contact\nUs",
        textStyle: const TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w800
        ),
        activeColorPrimary: const Color(0xFF0AC8F6),
      ),
    ];

    return MaterialApp(
      home: PersistentTabView(
        context,
        controller: tabCtr,
        screens: screens,
        confineInSafeArea: true,
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
        // popActionScreens: PopActionScreensType.all,
        itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
          duration: Duration(milliseconds: 200),
          curve: Curves.ease,
        ),
        navBarStyle: NavBarStyle.style1,
      ),
    );
  }
}