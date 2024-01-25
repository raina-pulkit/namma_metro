import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/template_page.dart';

import '../firebase_options.dart';

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _MyLoginState();
}

class _MyLoginState extends State<Login>{
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  void authUser() async{
    String email = emailCtrl.text.trim();
    String password = passCtrl.text.trim();

    if((email == "") || (password == "")){
      log("Fill in details properly!");
    }
    else{
      try{
        log("Here");
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
        log(exception.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context){
    if(FirebaseAuth.instance.currentUser != null) return const Template();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/login.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Stack(
                  children: [
                    Container(
                        padding: const EdgeInsets.only(left: 35, top: 130),
                        child: Text(
                          "Welcome\nBack",
                          style: GoogleFonts.rajdhani(
                              fontWeight: FontWeight.w800,
                              fontSize: 55,
                              color: Colors.white
                          ),
                        )
                    ),
                    SingleChildScrollView(
                      child: Container(
                        height: 400,
                        margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.39),
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.1, right: 35, left: 35),
                        child: Column(
                          children: [
                            TextField(
                              controller: emailCtrl,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Email / User Name",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextField(
                              controller: passCtrl,
                              obscureText: true,
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade100,
                                  filled: true,
                                  hintText: "Password",
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  )
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
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
                                    onPressed: () {},
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
                      ),
                    ),
                  ],
                ),
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
    );
  }
}