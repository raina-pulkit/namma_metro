import 'dart:developer';
import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../AuthPages/login_signup.dart';
import 'color.dart';
import 'edit_profile.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _ListBuilder{
  late final String data;
  late final IconData leadIcon;
  late final bool trailIcon;
  late final Color col;
  late final Function() onTap;

  _ListBuilder({
    required this.data,
    required this.leadIcon,
    this.trailIcon = true,
    required this.onTap,
    this.col = Colors.black54
  });

  GestureDetector buildListTile() {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black54
          ),
          child: Icon(leadIcon, color: Colors.white,),
        ),
        title: Text(
          data,
          style: GoogleFonts.rajdhani(
            fontSize: 25,
            fontWeight: FontWeight.w700,
            color: col
          ),
        ),
        trailing: trailIcon ? Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black54
          ),
          child: const Icon(Icons.arrow_right, color: Colors.grey,),
        ): null,
      ),
    );
  }
}

class _AccountState extends State<Account> {
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

  void signOut(){
    showDialog(
      context: context,
      builder: (context) {
        return BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
          child: AlertDialog(
            backgroundColor: Colors.deepPurpleAccent,
            title: Text(
              "Logout Confirmation",
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontSize: 30,
                fontWeight: FontWeight.w700
              ),
            ),
            content: Text(
              "Are you sure you want to log out?",
              style: GoogleFonts.rajdhani(
                color: Colors.white,
                fontWeight: FontWeight.w500,
                fontSize: 20
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: CustomTopAppBar(
        text: "Account Details",
        show: true,
        context: context,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Center(
          child: Column(
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
                  child: Image.asset(profile_pic)
                ),
              ),
              const SizedBox(height: 10,),
              Text(
                "Pulkit Raina",
                style: GoogleFonts.rajdhani(
                  fontSize: 40,
                  fontWeight: FontWeight.w700,
                ),
              ),
              Text(
                "pulkitraina2608@gmail.com",
                style: GoogleFonts.rajdhani(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontStyle: FontStyle.italic
                ),
              ),
              const SizedBox(height: 20,),
              ElevatedButton(
                onPressed: (){
                  PersistentNavBarNavigator.pushNewScreen(
                      context,
                      screen: const EditProfile(),
                  );
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(327, 50),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  elevation: 1,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  )
                ),
                child: Text(
                  "Edit Profile",
                  style: GoogleFonts.rajdhani(
                    fontWeight: FontWeight.w600,
                    fontSize: 20
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Divider(),
              const SizedBox(height: 10,),
              _ListBuilder(
                data: "Age: 23",
                leadIcon: Icons.account_box_outlined,
                trailIcon: false,
                onTap: (){}
              ).buildListTile(),
              _ListBuilder(
                data: "Address",
                leadIcon: Icons.map,
                onTap: (){}
              ).buildListTile(),
              _ListBuilder(
                data: "Metro Cards",
                leadIcon: Icons.credit_card,
                onTap: (){}
              ).buildListTile(),
              _ListBuilder(
                data: "Log Out",
                leadIcon: Icons.logout,
                col: Colors.red,
                onTap: signOut,
              ).buildListTile(),
            ],
          ),
        ),
      ),
    );
  }
}
