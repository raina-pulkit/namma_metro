
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/AuthPages/register.dart';
import 'package:namma_metro/Templates/template_page.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Templates/square_tile.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _MyLoginState();
}

class _MyLoginState extends State<Login>{
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void authUser() async{
    String email = emailCtrl.text.trim();
    String password = passCtrl.text.trim();

    if((email == "") || (password == "")){
      _showSnackBar(context, "Please fill all details");
    }
    else{
      try{
        UserCredential uc = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
        if(uc.user != null){
          Navigator.popUntil(context, (route) => route.isFirst);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Template(),
            ),
          );
        }
      }
      on FirebaseAuthException catch(exception){
        _showSnackBar(context, exception.message ?? "An error occurred");
      }
    }
  }

  void signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    try{
      UserCredential uc = await FirebaseAuth.instance.signInWithCredential(credential);
      if(uc.user != null){
        Navigator.popUntil(context, (route) => route.isFirst);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const Template(),
          ),
        );
      }
    }
    on FirebaseAuthException catch(exception){
      _showSnackBar(context, exception.message ?? "An error occurred! Try again!");
    }
  }

  void _showSnackBar(BuildContext context, String message) {
    log("Here");
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context){
    FirebaseAuth.instance.signOut();
    if(FirebaseAuth.instance.currentUser != null) return const Template();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/login.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            Container(
              padding: const EdgeInsets.only(left: 35, top: 130),
              child: Text(
                "Welcome\nBack",
                style: GoogleFonts.rajdhani(
                  fontWeight: FontWeight.w800,
                  fontSize: 55,
                  color: const Color.fromRGBO(200, 200, 200, 1),
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            SingleChildScrollView(
              child: Container(
                height: 500,
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.35),
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1, right: 35, left: 35),
                child: Builder(
                  builder: (context){
                   return Material(
                     color: Colors.transparent,
                     child: Column(
                       children: [
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: emailCtrl,
                              decoration: InputDecoration(
                                  labelText: 'Email',
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
                              controller: passCtrl,
                              obscureText: true,
                              decoration: InputDecoration(
                                  labelText: 'Password',
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
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              SquareTile(
                                imagePath: 'images/google.png',
                                onTap: signInWithGoogle,
                              ),
                              const Spacer(),
                              const Text(
                                "Log In",
                                style: TextStyle(
                                  color: Color(0xff4c505b),
                                  fontSize: 30, fontWeight: FontWeight.w700,
                                ),
                              ),
                              const SizedBox(width: 20,),
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: const Color(0xff4c505b),
                                child: IconButton(onPressed: authUser, icon: const Icon(Icons.arrow_forward)),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => const RegisterPage(),
                                      ),
                                    );
                                  },
                                  child: const Text(
                                    "Sign Up",
                                    style: TextStyle(
                                      decoration: TextDecoration.underline,
                                      fontSize: 20,
                                      color: Color(0xff4c505b),
                                    ),
                                  )
                              ),
                              // SizedBox(
                              //   width: 20,
                              // ),
                              TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    "Forgot Password",
                                    style: TextStyle(
                                        decoration: TextDecoration.underline,
                                        fontSize: 20,
                                        color: Color(0xff4c505b)
                                    ),
                                  )
                              ),
                            ],
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