import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/peristent_bottom_nav_bar.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget{
  final String text;
  final bool show;
  final BuildContext context;

  const CustomTopAppBar({super.key,
    required this.text,
    required this.show,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      decoration: BoxDecoration(
        gradient: lgBtm(),
      ),
      padding: const EdgeInsets.only(top: 20),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            show? SizedBox(
              height: 45,
              width: 45,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(this.context),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  backgroundColor: Colors.transparent,
                ),
                child: SvgPicture.asset(
                  'images/left-arrow.svg',
                  semanticsLabel: 'Left Arrow',
                  height: 30,
                  width: 30,
                  colorFilter: const ColorFilter.mode(Colors.white, BlendMode.srcIn),
                ),
              ),
            ): const SizedBox(height: 45, width: 45,),
            Container(
              margin: const EdgeInsets.only(left: 20),
              child: Text(
                text,
                style: GoogleFonts.rajdhani(
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                  color: Colors.white,
                  decoration: TextDecoration.none
                ),
              ),
            ),
            const Spacer(),
            const Image(
              image: ResizeImage(
                AssetImage('images/circle_logo.png'),
                width: 50,
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(80);
}