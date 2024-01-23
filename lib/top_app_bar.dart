import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

LinearGradient lgTop() {
  return const LinearGradient(
    colors: <Color>[
      Color(0xff1f005c),
      Color(0xff972f9b),
      Color(0xff941e70),
      Color(0xffac255e),
      Color(0xffca485c),
      Color(0xffe16b5c),
      Color(0xfff39060),
      Color(0xffffb56b),
    ],
  );
}

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String text;

  const CustomTopAppBar({super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: lgTop(),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(
            height: 45,
            width: 45,
            child: ElevatedButton(
                onPressed: () {
                stdout.write("Hello");
              },
              style: ElevatedButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero
              ),
              child: SvgPicture.asset(
                'images/left-arrow.svg',
                semanticsLabel: 'Left Arrow',
                height: 30,
                width: 30,
              ),
            ),
          ),
          Text(
            text,
            style: GoogleFonts.rajdhani(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              color: Colors.white,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: const Image(
              image: ResizeImage(
                AssetImage('images/circle_logo.png'),
                width: 50,
                height: 50,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}