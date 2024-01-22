import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

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

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const int col = 15;
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: const Color.fromRGBO(col, col, col, 0.7),
        titleTextStyle: const TextStyle(
          color: Colors.deepPurpleAccent,
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75),
            )
          ]
        ),
        child: BottomNavigationBar(
          unselectedLabelStyle: const TextStyle(
              color: Colors.white,
              fontSize: 14,
          ),
          unselectedItemColor: Colors.white,
          fixedColor: Colors.deepPurpleAccent,
          backgroundColor: const Color.fromRGBO(col, col, col, 0.8),
          elevation: 0,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.home_outlined,
                color: Colors.white,
              ),
              label: 'Home',
              // backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                Icons.airplane_ticket_outlined,
                color: Colors.white,
              ),
              label: 'Tickets',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(
                  Icons.account_circle,
                  color: Colors.white,
              ),
              label: 'Account',
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
