import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/Contact_Us/contact_us.dart';
import 'package:namma_metro/Pages/Home/first_last_metro.dart';
import 'package:namma_metro/Pages/Home/lost_found.dart';
import 'package:namma_metro/Pages/Home/time_table.dart';
import 'package:namma_metro/Pages/Home/tour_guide.dart';
import 'package:namma_metro/Pages/Metro_Lines/metro_lines.dart';
import 'package:namma_metro/Pages/Ticket_Booking/book_qr_ticket.dart';
import 'package:namma_metro/Pages/Ticket_Booking/fare_calculator.dart';
import 'package:namma_metro/Pages/Ticket_Booking/plan_your_journey.dart';
import 'package:namma_metro/Pages/Ticket_Booking/smartcard_recharge.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../top_app_bar.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
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
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
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
    "Plan Your Journey",
    "Book QR Ticket",
    "Metro Card Top Up",
    "Fare Calculator",
    "Tour Guide",
    "Metro Lines",
    "Time Table",
    "First & Last\n Metro Time",
    "Lost & Found",
    "Contact Us",
  ];

  final page = [
    const PlanYourJourney(title: "Plan your journey", show: true),
    const BookQRTicket(),
    const SmartCardRecharge(),
    const FareCalculator(),
    const TourGuide(),
    const MetroLines(),
    const TimeTable(),
    const FirstLastMetro(),
    const LostFound(),
    const ContactPage(show: true,)
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        child: Column(
          children: [
            CustomTopAppBar(text: "Search", show: false, context: context),
            Container(
              margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
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
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    itemCount: page.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async => await PersistentNavBarNavigator.pushNewScreen(
                          context,
                          screen: page[index],
                        ),
                        child: listItem(profile[index]),
                      );
                    },
                    separatorBuilder: (context, index) => const SizedBox(height: 15,),
                  );
                },
              ),
            ),
            const SizedBox(height: 25,),
          ],
        ),
      ),
    );
  }
}
