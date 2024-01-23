// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:namma_metro/bottom_nav_bar.dart';
import 'package:namma_metro/top_app_bar.dart';

var msg = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut elementum auctor varius. Vestibulum eu massa a dui euismod pretium. Interdum et malesuada fames ac ante ipsum primis in faucibus. Praesent non purus tincidunt augue luctus lacinia. Etiam convallis eu magna ac dignissim. Pellentesque sit amet pretium tortor. Vivamus posuere lorem et odio vehicula, nec viverra lectus rutrum. Vestibulum fermentum rutrum accumsan. Fusce justo libero, sodales a blandit quis, eleifend nec purus. Ut at leo urna. Fusce vitae mauris accumsan, dignissim magna accumsan, euismod ante. Donec sodales ex nec lorem mollis euismod. Suspendisse potenti. Etiam vestibulum accumsan justo, et imperdiet ipsum viverra interdum. Nulla sodales placerat aliquam. Nullam quam libero, tincidunt ut lacinia sed, egestas mattis quam. Aenean volutpat, arcu sed consequat imperdiet, elit tortor aliquet massa, id porttitor purus sem at leo. In hac habitasse platea dictumst. Suspendisse vestibulum eget nunc eu aliquam. Vestibulum pellentesque hendrerit ipsum at elementum. Integer vehicula lobortis ex, eget dignissim leo cursus ut. Vivamus pharetra laoreet odio non tristique. Sed fringilla cursus mauris vitae consectetur. Duis eget faucibus velit. In bibendum leo ut nisi bibendum, in mollis ante auctor. Aenean sodales at augue eget commodo. Aliquam mollis malesuada neque, ut interdum arcu. Suspendisse eu nibh ex. Vivamus bibendum iaculis orci non gravida. Sed aliquam nisi tellus, sed fringilla ipsum cursus at. Vestibulum vehicula urna at mattis laoreet. Aliquam blandit leo diam, ac pellentesque lorem ultrices a. Nam lorem nisl, consequat vitae consequat sed, venenatis et neque. Aliquam non massa pulvinar, sodales nisl id, dapibus massa.";


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
  State<MyHomePage> createState() => _My_Home_Page_State();
}

class _My_Home_Page_State extends State<MyHomePage>{
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomTopAppBar(text: "Home Page"),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Center(
          child: Text(
            msg,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        }
      ),
    );
  }
}