import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/AuthPages/register.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../Pages/peristent_bottom_nav_bar.dart';
import 'square_tile.dart';
import 'forgot_password.dart';
import 'login_signup.dart';

class PasswordField extends StatefulWidget {
  final TextEditingController controller;

  const PasswordField({Key? key, required this.controller}) : super(key: key);

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscure,
      decoration: InputDecoration(
        labelText: 'Password',
        fillColor: Colors.grey.shade100,
        filled: true,
        prefixIcon: const Icon(Icons.password),
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
          icon: Icon(_obscure ? Icons.visibility : Icons.visibility_off),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

class Login extends StatefulWidget{
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _MyLoginState();
}

class _MyLoginState extends State<Login>{
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passCtrl = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get defImg => "https://firebasestorage.googleapis.com/v0/b/namma-metro-36b56.appspot.com/o/images%2Fprofile_pic.png?alt=media&token=b7771536-f13e-4c68-af84-8dc013dfdb5f";

  void authUser() async{
    String email = emailCtrl.text.trim();
    String password = passCtrl.text.trim();

    if((email == "") || (password == "")){
      _showSnackBar("Please fill all details");
    }
    else{
      try{
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        ).then((result) async {
          if(result.user != null){
            Navigator.popUntil(context, (route) => route.isFirst);
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PersistentNavBar(),
              ),
            );
          }
        });
      }
      on FirebaseAuthException catch(exception){
        _showSnackBar(exception.message ?? "An error occurred");
      }
    }
  }

  void signInWithGoogle() async {
    await GoogleSignIn().signOut();

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
      await FirebaseAuth.instance.signInWithCredential(credential)
      .then((result) async{
        if(result.user != null){
          String? email = result.user?.email;
          String? uid = result.user?.uid;
          String? userName = result.user!.displayName;
          DocumentSnapshot snap = await FirebaseFirestore.instance.collection('user_details').doc(uid).get();
          if(!snap.exists){
            var data = {
              'email': email,
              'user_name': userName,
            };
            await FirebaseFirestore.instance.collection('users').doc(uid)
            .set(data)
            .then((res) async{
              Map<String, dynamic> data2= {
                'user_id': uid,
                "address": "`",
                "age": -1,
                "phone_number": -1,
                "profile_pic": defImg
              };

              await FirebaseFirestore.instance.collection("user_details").doc(uid)
              .set(data2)
              .then((res) {
                Navigator.popUntil(
                  context,
                  (route) => route.isFirst,
                );
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PersistentNavBar(),
                  ),
                );
              });
            });
          }
          else{
            Future.delayed(Duration.zero).then((res) {
              Navigator.popUntil(
                context,
                    (route) => route.isFirst,
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => const PersistentNavBar(),
                ),
              );
            });
          }
        }
        else{
          Navigator.popUntil(
            context,
            (route) => route.isFirst,
          );
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const PersistentNavBar(),
            ),
          );
        }
      });
    }

    on FirebaseAuthException catch(exception){
      _showSnackBar(exception.message ?? "An error occurred! Please try again!");
    }
    catch(e){
      _showSnackBar(e.toString());
    }
  }

  void _showSnackBar(String message) {
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
    if(FirebaseAuth.instance.currentUser != null){
      Navigator.popUntil(
        context,
        (route) => route.isFirst
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PersistentNavBar()));
      return const PersistentNavBar();
    }

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
                              prefixIcon: const Icon(Icons.email),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              )
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Builder(
                          builder: (context) {
                            return Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: PasswordField(controller: passCtrl,),
                            );
                          }
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
                              child: IconButton(onPressed: authUser, icon: const Icon(Icons.arrow_forward, color: Colors.white,)),
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
                                Navigator.popUntil(context, (route) => route.isFirst);
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

                            TextButton(
                                onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ForgotPasswordPage(),
                                  ),
                                ),
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
                  child: ColorFiltered(
                    colorFilter: const ColorFilter.mode(
                      Colors.white,
                      BlendMode.srcIn
                    ),
                    child: SvgPicture.asset(
                      'images/left-arrow.svg',
                      semanticsLabel: 'Left Arrow',
                      height: 30,
                      width: 30,
                    ),
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