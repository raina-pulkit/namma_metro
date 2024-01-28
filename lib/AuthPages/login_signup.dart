import 'package:flutter/material.dart';
import 'package:namma_metro/Pages/color.dart';
import 'package:namma_metro/AuthPages/plain_login_borders.dart';
import 'package:namma_metro/AuthPages/login.dart';
import 'package:namma_metro/AuthPages/register.dart';
import '../Pages/peristent_bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginSignup extends StatelessWidget{
  const LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
    if(FirebaseAuth.instance.currentUser != null) return const PersistentNavBar();

    Container c = Container(
      height: 500,
      padding: EdgeInsets.zero,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 30),
            child: Image.asset(
              'images/straight_logo.png',
              height: 100,
              width: 300,
            ),
          ),
          SizedBox(
            height: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const Login(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.account_circle_outlined, size: 30,),
                  label: Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: secondary
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RegisterPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add_box_outlined, size: 30,),
                  label: Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: secondary
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
    return LoginBorder(cont: c);
  }
}