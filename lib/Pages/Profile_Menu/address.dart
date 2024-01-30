import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

import '../color.dart';

class Address extends StatelessWidget {
  final String add;
  const Address({super.key, required this.add});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
          text: "Addess",
          show: true,
          context: context
      ),
      body: Center(
        child: Container(
          width: 300,
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(30)),
            boxShadow: const [
              BoxShadow(
                color: Color.fromRGBO(25, 25, 25, 0.7),
                blurRadius: 20,
                offset: Offset(2, 2)
              )
            ],
            color: secondary
          ),
          child: Text(
            add==""?"Address not set yet":add,
            style: GoogleFonts.rajdhani(
              fontSize: 35,
              fontWeight: FontWeight.w800
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
