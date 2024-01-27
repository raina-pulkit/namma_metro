import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/color.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../AuthPages/login_signup.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final String profile_pic = "images/profile_pic.png";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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

  void saveProfile(){
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: AlertDialog(
              backgroundColor: Colors.deepPurpleAccent,
              title: Text(
                "Save Profile?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700
                ),
              ),
              content: Text(
                "Are you sure you want to save your details?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "No",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      await FirebaseAuth.instance.signOut().then((res) {
                        Navigator.popUntil(context, (route) => false);
                        PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: const LoginSignup(),
                          withNavBar: false,
                          pageTransitionAnimation: PageTransitionAnimation
                              .cupertino,
                        );
                      });
                    }
                    catch (e) {
                      _showSnackBar(
                          "Couldn't Log Out, try again! ${e.toString()}",
                          Colors.red
                      );
                    }
                  },
                  child: Text(
                    "Yes",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  void deleteProfile(){
    showDialog(
        context: context,
        builder: (context) {
          return BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
            child: AlertDialog(
              backgroundColor: Colors.redAccent,
              title: Text(
                "DELETE PROFILE?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w700
                ),
              ),
              content: Text(
                "ARE YOU SURE YOU WANT TO DELETE YOUR PROFILE?",
                style: GoogleFonts.rajdhani(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 20
                ),
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    "No",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () async {
                    try {
                      User? user = FirebaseAuth.instance.currentUser;
                      await user?.delete().then((result){
                        showDialog(
                          context: context,
                          builder: (context){
                            return BackdropFilter(
                              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                              child: AlertDialog(
                                backgroundColor: Colors.greenAccent,
                                title: Text(
                                  "Profile Deleted!",
                                  style: GoogleFonts.rajdhani(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.w700
                                  ),
                                ),
                                content: Text(
                                  "Your profile was successfully deleted!",
                                  style: GoogleFonts.rajdhani(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20
                                  ),
                                ),
                              ),
                            );
                          }
                        );
                        Navigator.popUntil(
                            context, (route) => false
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginSignup())
                        );
                      });
                    }
                    catch (e) {
                      _showSnackBar(
                          "Couldn't delete profile, try again! ${e.toString()}",
                          Colors.red
                      );
                    }
                  },
                  child: Text(
                    "Yes",
                    style: GoogleFonts.rajdhani(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w700
                    ),
                  ),
                ),
              ],
            ),
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondary,
      appBar: CustomTopAppBar(
        text: "Edit Profile",
        show: true,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(30),
          child: Center(
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      // margin: const EdgeInsets.only(top: 10),
                      width: 120, height: 120,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(100),
                          child: Image.asset(profile_pic)),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: GestureDetector(
                          onTap: (){},
                          child: Container(
                            width: 35,
                            height: 35,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black54
                            ),
                            child: const Icon(Icons.add_a_photo_rounded, color: Colors.white,),
                          ),
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Form(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.black54
                          ),
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: const Icon(Icons.email, color: Colors.white,)
                          ),
                        ),
                        title: Text(
                          "pulkitraina2608@gmail.com",
                          style: GoogleFonts.rajdhani(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Name",
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(80),
                              ),
                              prefixIcon: const Icon(Icons.person)
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: "Address",
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(80),
                            ),
                            prefixIcon: const Icon(Icons.map)
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        child: TextField(
                          decoration: InputDecoration(
                              labelText: "Phone Number",
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(80),
                              ),
                              prefixIcon: const Icon(Icons.phone_android)
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      ElevatedButton(
                        onPressed: saveProfile,

                        style: ElevatedButton.styleFrom(
                            minimumSize: const Size(327, 50),
                            backgroundColor: Colors.black87,
                            foregroundColor: Colors.white,
                            elevation: 1,
                            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(Radius.circular(50)),
                            )
                        ),
                        child: Text(
                          "Save Profile",
                          style: GoogleFonts.rajdhani(
                              fontWeight: FontWeight.w600,
                              fontSize: 25
                          ),
                        ),
                      ),
                      const SizedBox(height: 15,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: (){
                              PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: const EditProfile(),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(20, 20),
                                backgroundColor: Color.fromRGBO(5, 87, 119, 1.0),
                                foregroundColor: Colors.white,
                                elevation: 1,
                                padding: const EdgeInsets.all(30),
                                shape: const CircleBorder()
                            ),
                            child: Text(
                              "Change\nPassword",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rajdhani(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25
                              ),
                            ),
                          ),
                          ElevatedButton(
                            onPressed: deleteProfile,
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(20, 20),
                                backgroundColor: const Color.fromRGBO(175, 19, 19, 1.0),
                                foregroundColor: Colors.white,
                                elevation: 1,
                                padding: const EdgeInsets.all(30),
                                shape: const CircleBorder()
                            ),
                            child: Text(
                              "Delete \nAccount",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.rajdhani(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 25
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}