import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:namma_metro/AuthPages/login.dart';
import '../firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
}

const firebase_proj = "namma-metro-36b56";