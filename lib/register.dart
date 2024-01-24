import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

void main() => runApp(const RegisterPage());

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Stack(
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
              child: Material(
                color: Colors.transparent,
                child: Column(
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: "User Name",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                          fillColor: Colors.grey.shade100,
                          filled: true,
                          hintText: "Email",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextField(
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {},
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
                                child: IconButton(onPressed: () {}, icon: const Icon(Icons.arrow_forward)),
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
                  stdout.write("Hello");
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
