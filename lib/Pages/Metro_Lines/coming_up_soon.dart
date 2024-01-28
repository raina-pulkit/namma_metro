import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class ComingSoon extends StatelessWidget {
  const ComingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: CustomTopAppBar(
          text: "COMING SOON",
          show: true,
          context: context,
        ),
        body: Center(
          child: Text(
            "Coming\nSoon!",
            style: GoogleFonts.rajdhani(
              fontSize: 100,
              letterSpacing: 1,
              fontWeight: FontWeight.w700,
              shadows: [
                const Shadow(
                  offset: Offset(2, 2),
                  blurRadius: 3,
                  color: Colors.black
                )
              ],
            ),
            textAlign: TextAlign.center,
          )
        ),
      ),
    );
  }
}
