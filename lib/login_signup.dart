import 'package:flutter/material.dart';
import 'package:namma_metro/plain_login_borders.dart';

void main() => runApp(const LoginSignup());

class LoginSignup extends StatelessWidget{
  const LoginSignup({super.key});

  @override
  Widget build(BuildContext context) {
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
                  onPressed: () {},
                  icon: const Icon(Icons.account_circle_outlined, size: 30,),
                  label: const Text(
                    "Login",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 35),
                    // backgroundColor: Colors.transparent
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined, size: 30,),
                  label: const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
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