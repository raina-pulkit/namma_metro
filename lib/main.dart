import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/loading_page.dart';
import 'Pages/faq.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseAuth.instance.signOut();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Main Page',
      theme: ThemeData(
        primarySwatch: Colors.purple,
        textTheme: GoogleFonts.rajdhaniTextTheme(
          Theme.of(context).textTheme,
        ),
        secondaryHeaderColor: Colors.deepPurpleAccent
      ),
      home: const LoadingPage(),
    );
  }
}