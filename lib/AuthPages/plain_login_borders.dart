import 'package:flutter/material.dart';
import 'package:namma_metro/Pages/peristent_bottom_nav_bar.dart';

class LoginBorder extends StatelessWidget{
  final Container cont;
  const LoginBorder({super.key, required this.cont});

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
              gradient: lgBtm(),
            ),
          ),
          const Spacer(),
          Center(
            child: Container(
              color: Colors.transparent,
              child: cont,
            ),
          ),
          const Spacer(),
          Container(
            height: 80,
            decoration: BoxDecoration(
              gradient: lgBtm(),
            ),
          ),
        ],
      ),
    );
  }
}