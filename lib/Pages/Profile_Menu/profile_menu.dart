import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/AuthPages/login_signup.dart';
import 'package:namma_metro/Pages/color.dart';
import 'package:namma_metro/Pages/Ticket_Booking/smartcard_recharge.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import '../Ticket_Booking/my_cards.dart';
import 'account.dart';
import 'faq.dart';
import 'my_tickets.dart';

class ProfileMenu extends StatefulWidget {
  const ProfileMenu({super.key});

  @override
  State<ProfileMenu> createState() => _ProfileMenuState();
}

class _ProfileMenuState extends State<ProfileMenu> {
  Widget listItem(String s){
    return Container(
      height: 85,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(topRight: Radius.circular(25), bottomLeft: Radius.circular(25)),
        boxShadow: [
          BoxShadow(
            color: Color(0xFFEEEEEE),
            spreadRadius: 5,
            offset: Offset(0, 3), // changes the position of the shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            s,
            style: GoogleFonts.rajdhani(
              fontSize: 30,
              fontWeight: FontWeight.w700,
              color: Colors.black,
              decoration: TextDecoration.none
            ),
          ),
          const Icon(Icons.arrow_forward_ios)
        ],
      ),
    );
  }

  final profile = [
    "My Details",
    "Ticket History",
    "My Cards",
    "Smart Card \nRecharge",
    "FAQ"
  ];

  final page = [
    const Account(),
    const MyTickets(),
    const MyCards(),
    const SmartCardRecharge(),
    const FAQ()
  ];

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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Colors.white,
      child: SingleChildScrollView(
        child: Column(
          children: [
            CustomTopAppBar(text: "Profile Menu", show: false, context: context),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
              height: 540,
              width: 400,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: const Color.fromRGBO(120, 100, 175, 0.6),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes the position of the shadow
                  ),
                ],
              ),
              child: Builder(
                  builder: (context) {
                    return ListView.separated(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),

                        itemCount: 5,
                        itemBuilder: (context, index){
                          return GestureDetector(
                            onTap: () async => await PersistentNavBarNavigator.pushNewScreen(
                                context,
                                screen: page[index]
                            ),
                            child: listItem(profile[index]),
                          );
                        },
                        separatorBuilder: (context, index) => const SizedBox(height: 15,)
                    );
                  }
              ),
            ),
            const SizedBox(height: 25,),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  shadowColor: secondary,
                  padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Button padding
                ),
                onPressed: () {
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
                                  try{
                                    await FirebaseAuth.instance.signOut().then((res) {
                                      Navigator.popUntil(context, (route) => false);
                                      PersistentNavBarNavigator.pushNewScreen(
                                        context,
                                        screen: const LoginSignup(),
                                        withNavBar: false,
                                        pageTransitionAnimation: PageTransitionAnimation.cupertino,
                                      );
                                    });
                                  }
                                  catch(e){
                                    _showSnackBar("Couldn't Log Out, try again! ${e.toString()}", Colors.red);
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
                },
                child: Text(
                  "Log Out",
                  style: GoogleFonts.rajdhani(
                      fontSize: 23,
                      fontWeight: FontWeight.w800
                  ),
                )
            ),
          ],
        ),
      ),
    );
  }
}
