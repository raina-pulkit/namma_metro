import 'package:flutter/material.dart';
import 'package:namma_metro/bottom_nav_bar.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Metro Ticket Booking',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _My_Home_Page_State createState() => _My_Home_Page_State();
}

class _My_Home_Page_State extends State<MyHomePage>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(20, 20, 20, 0.8),
        titleTextStyle: const TextStyle(
          color: Color.fromRGBO(255, 255, 255, 1),
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        title: const Center(
          child: Column(
            children: [
              Text(
                'Welcome to Metro Booking',
              ),
              Text(
                "Pulkit",
                style: TextStyle(
                    color: Colors.blueAccent,
                    fontStyle: FontStyle.italic
                ),
                textAlign: TextAlign.left,
              )
            ],
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        toolbarTextStyle: const TextStyle(
          color: Colors.red,
        ),
      ),
      body: const Center(
        child: Text(
          'Content goes here',
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}