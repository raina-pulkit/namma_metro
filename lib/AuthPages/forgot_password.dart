import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namma_metro/AuthPages/register.dart';
import 'package:namma_metro/Pages/peristent_bottom_nav_bar.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  TextEditingController emailCtrl = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void dispose(){
    emailCtrl.dispose();
    super.dispose();
  }

  Future passwordReset() async{
    String email = emailCtrl.text.toString().trim();
    if(email == ""){
      _showSnackBar("Please fill email properly!", Colors.red);
    }
    else{
      try{
        await FirebaseAuth.instance.sendPasswordResetEmail(email: emailCtrl.text.toString().trim());
        _showSnackBar("Password reset link sent! Please check your email", Colors.green);
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
      home: Scaffold(
        key: _scaffoldKey,
        appBar: CustomTopAppBar(text: 'Reset Password', show: true, context: context),
        body: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height*0.25,
                  right: 25,
                  left: 25
              ),
              child: Builder(
                builder: (context){
                  return Material(
                    color: Colors.transparent,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                                onPressed: () {
                                  Navigator.popUntil(
                                    context,
                                    (route) => route.isFirst
                                  );
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
                            Row(
                              children: [
                                const Text(
                                  "Reset Password",
                                  style: TextStyle(
                                    color: Color(0xff4c505b),
                                    fontSize: 20,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(width: 10,),
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: const Color(0xff4c505b),
                                  child: IconButton(
                                    onPressed: passwordReset,
                                    icon: const Icon(
                                      Icons.arrow_forward,
                                      color: Colors.white,
                                    )
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                }
              ),
            ),
          ),
        ),
        bottomNavigationBar: Container(
          height: 80,
          decoration: BoxDecoration(
            gradient: lgBtm(),
            borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
                bottom: Radius.circular(0)
            ),
          ),
        ),
      ),
    );
  }
}
