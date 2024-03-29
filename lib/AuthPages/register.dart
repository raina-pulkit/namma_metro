import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/AuthPages/login.dart';
import 'package:namma_metro/AuthPages/login_signup.dart';


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController userNameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController phNoCtrl = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  get defImg => "https://firebasestorage.googleapis.com/v0/b/namma-metro-36b56.appspot.com/o/images%2Fprofile_pic.png?alt=media&token=b7771536-f13e-4c68-af84-8dc013dfdb5f";

  void createUser() async{
    String userName = userNameCtrl.text;
    String email = emailCtrl.text.trim();
    String password = passwordCtrl.text.trim();
    String phNoStr = phNoCtrl.text.trim();
    if(phNoStr.length != 10){
      _showSnackBar("Please fill all details", Colors.red);
      return;
    }

    int phNo = int.parse(phNoStr);

    if((password == "") || (email == "") || (userName == "") || (phNo == 0)){
      _showSnackBar("Please fill all details", Colors.red);
    }
    else{
      try{
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          password: password,
          email: email,
        ).then((result) async {
          if(result.user != null){
            User? u = FirebaseAuth.instance.currentUser;
            String? userId = u!.uid;
            await FirebaseFirestore.instance.collection('users')
              .doc(userId)
              .set({
                'email': email,
                'user_name': userName,
            }).then((value) async {
              await FirebaseFirestore.instance.collection("user_details")
              .doc(userId)
              .set({
                'user_id': userId,
                'address': "`",
                'age': -1,
                'phone_number': -1,
                'profile_pic': defImg,
              }).then((res) {
                FirebaseAuth.instance.signOut();
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginSignup()),
                );
              });
            });
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
                margin: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.25),
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
                                  prefixIcon: const Icon(Icons.person)
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
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
                                  ),
                                  prefixIcon: const Icon(Icons.email)
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: TextField(
                                controller: phNoCtrl,
                                decoration: InputDecoration(
                                    labelText: "Phone Number",
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: const Icon(Icons.dialpad)
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              child: PasswordField(controller: passwordCtrl,),
                            ),
                            const SizedBox(
                              height: 15,
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
                                            onPressed: () => createUser(),
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