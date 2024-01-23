// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/home.dart';

class LoadingPage extends StatefulWidget{
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage>{
  @override
  void initState(){
    super.initState();

    Future.delayed(
      const Duration(seconds: 5), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => _Another_Page(),
            )
          );
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Image.asset(
                'images/straight_logo.png',
                height: 350,
                width: 350,
                fit: BoxFit.contain,
              ),
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
              child: Text(
                "Seamless Commutes, Limitless Connections",
                style: GoogleFonts.rajdhani(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  fontStyle: FontStyle.italic,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

class _Another_Page extends StatefulWidget{
  @override
  AnotherPage createState() => AnotherPage();
}

class AnotherPage extends State<_Another_Page>{
  @override
  void initState(){
    super.initState();

    Future.delayed(
        const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const MyApp(),
          )
      );
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(''),
      ),
      body: Column(
        children: [
          Center(
            child: Image.asset(
                'images/woman.png',
              height: 400,
              width: 250,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            decoration: const BoxDecoration(
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black45,
                  blurRadius: 15.0,
                  offset: Offset(0.0, 0.75),
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(20)),
              color: Colors.white60,
            ),
            child: Image.asset(
              'images/straight_logo.png',
              height: 100,
              width: 300,
              fit: BoxFit.contain,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Text(
              "Welcomes you!",
              style: GoogleFonts.rajdhani(
                fontSize: 50,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}