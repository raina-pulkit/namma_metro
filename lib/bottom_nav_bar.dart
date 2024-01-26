import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:namma_metro/AuthPages/register.dart';
import 'package:namma_metro/sample.dart';

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

// To be added
const screens = [
  RegisterPage(),
  MyApp(),
  RegisterPage()
];

class CustomBottomNavigationBar extends StatefulWidget {
  final int currentIndex;
  const CustomBottomNavigationBar({super.key, required this.currentIndex});

  @override
  State<CustomBottomNavigationBar> createState() => _CustomBottomNavigationBar();
}


class _CustomBottomNavigationBar extends State<CustomBottomNavigationBar> {
  int index = 0;

  static const items = <Widget>[
    Icon(Icons.home),
    Icon(Icons.airplane_ticket_outlined),
    Icon(Icons.account_circle),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: screens[index],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          iconTheme: const IconThemeData(color: Colors.white),
        ),
        child: CurvedNavigationBar(
          color: const Color(0xff870160),
          backgroundColor: Colors.transparent,
          buttonBackgroundColor: Colors.black,
            items: items,
          height: 60,
          index: index,
          onTap: (index){
            setState(() {
              this.index = index;
            });
          },
          animationDuration: const Duration(milliseconds: 300),
        ),
      ),
    );
  }
}