import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/home.dart';

class LoadingPage extends StatefulWidget{
  const LoadingPage({super.key});

  @override
  _LoadingPageState createState() => _LoadingPageState();
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
        title: const Text('Welcome!'),
      ),
      body: Center(
        child: Image.asset(
            'images/woman.png'
        ),
      ),
    );
  }
}