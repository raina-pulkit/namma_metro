import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/AuthPages/login_signup.dart';
import 'package:namma_metro/Pages/smartcard_recharge.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';
import 'package:namma_metro/Pages/transaction_history.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
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
      height: 70,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(25)),
        color: Colors.white60,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes the position of the shadow
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
              color: const Color.fromRGBO(20, 20, 20, 0.8),
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
    "Transaction History",
    "My Tickets",
    "Smart Card \nRecharge",
    "FAQ"
  ];

  final page = [
    Account(),
    TransactionHistory(),
    MyTickets(),
    SmartCardRecharge(),
    FAQ()
  ];
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: const ColorScheme(
          primary: Colors.blue,
          secondary: Colors.green,
          surface: Colors.white,
          background: Colors.white,
          error: Colors.red,
          onPrimary: Colors.white,
          onSecondary: Colors.black,
          onSurface: Colors.black,
          onBackground: Colors.black,
          onError: Colors.white,
          brightness: Brightness.light,
        ),
        textTheme: const TextTheme(
          labelSmall: TextStyle(
            decoration: TextDecoration.none
          )
        ),
      ),
      home: Container(
        height: double.infinity,
        width: double.infinity,
        color: const Color.fromRGBO(255, 255, 255, 0.4),
        child: Column(
          children: [
            CustomTopAppBar(text: "Profile Menu", show: false, context: context),
            Container(
              margin: const EdgeInsets.only(top: 50, left: 20, right: 20),
              height: 500,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(25)),
                color: Colors.grey,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes the position of the shadow
                  ),
                ],
              ),
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 30),

                itemCount: 5,
                itemBuilder: (context, index){
                  return GestureDetector(
                    onTap: () => page[index],
                    child: listItem(profile[index]),
                  );
                },
                separatorBuilder: (context, index) => const SizedBox(height: 20,)
              ),
            ),
            const SizedBox(height: 25,),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: const Color.fromRGBO(0, 0, 0, 0.7),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                ),
                padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20), // Button padding
              ),
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.popUntil(context, (route) => route.isFirst);
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const LoginSignup(),
                  withNavBar: false, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: Text(
                "Log Out",
                style: GoogleFonts.rajdhani(
                  fontSize: 23,
                  fontWeight: FontWeight.w800
                ),
              )
            )
          ],
        ),
      ),
    );
  }
}