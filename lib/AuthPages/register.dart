import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/AuthPages/login.dart';
import 'package:namma_metro/AuthPages/login_signup.dart';


void main() => runApp(const RegisterPage());

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Future<void> createUser() async{
    String userName = userNameCtrl.text;
    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();

    if((password == "") || (email == "") || (userName == "")){
      _showSnackBar("Please fill all details", Colors.red);
    }
    else{
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email,
            password: password
        ).then((result) {
          if(result.user != null){
            Navigator.pop(context);
          }
        });
      }
      on FirebaseAuthException catch(exception){
        _showSnackBar(exception.message ?? "An error occurred", Colors.red);
      }
    }
  }

  void _showSnackBar(String message, Color col) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: col,
        duration: const Duration(seconds: 3),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/register.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(left: 35, top: 100),
              child: Text(
                "Create\nAccount",
                style: GoogleFonts.rajdhani(
                  fontWeight: FontWeight.w800,
                  fontSize: 55,
                  color: Colors.white,
                  decoration: TextDecoration.none,
                ),
              ),
            ),

            SingleChildScrollView(
              child: Container(
                height: 500,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.3),
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1, right: 35, left: 35),
                child: Builder(
                    builder: (context) {
                      return Material(
                        color: Colors.transparent,
                        child: Column(
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: userNameCtrl,
                                decoration: InputDecoration(
                                  labelText: "User Name",
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: emailCtrl,
                                decoration: InputDecoration(
                                    labelText: "Email",
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: passwordCtrl,
                                obscureText: true,
                                decoration: InputDecoration(
                                    labelText: "Password",
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    )
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.popUntil(context, (route) => route.isFirst);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const Login(),
                                        ),
                                      );
                                    },
                                    child: const Text(
                                      "Login",
                                      style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 25,
                                        color: Color(0xff4c505b),
                                      ),
                                    )
                                ),
                                Row(
                                    children: [
                                      const Text(
                                        "Sign Up",
                                        style: TextStyle(
                                          color: Color(0xff4c505b),
                                          fontSize: 25, fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      const SizedBox(width: 20,),
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundColor: const Color(0xff4c505b),
                                        child: IconButton(
                                            onPressed: () async => await createUser(),
                                            icon: const Icon(Icons.arrow_forward)
                                        ),
                                      )
                                    ]
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      );
                    }
                ),
              ),
            ),

            Positioned(
              top: 30,
              left: 10,
              child: SizedBox(
                height: 50,
                width: 50,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginSignup()
                        )
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.all(8),
                    backgroundColor: Colors.transparent,
                  ),
                  child: SvgPicture.asset(
                    'images/left-arrow.svg',
                    semanticsLabel: 'Left Arrow',
                    height: 30,
                    width: 30,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}