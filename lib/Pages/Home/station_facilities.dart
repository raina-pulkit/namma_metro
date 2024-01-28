import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';


class StationFacilities extends StatelessWidget {
  const StationFacilities({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Station Facilities",
        show: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'images/CustomerCare.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Customer Care',
                      style: GoogleFonts.rajdhani(
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'The Customer care is located on the station to assist passengers regarding any problem about their tickets. It is usually located between entry and exit gates and is accessible from both paid and unpaid area. Those who need to pay excess fares or obtain assistance with malfunctioning tickets may also visit the Customer Care at stations.',
                      style: GoogleFonts.rajdhani(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Image.asset(
                  'images/DisplayBoards.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Passenger Information Display Boards',
                      style: GoogleFonts.rajdhani(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Passenger Information Display Boards are installed near the Automatic gates and on platform to provide real-time information to passengers about the arrival of trains.',
                      style: GoogleFonts.rajdhani(
                          fontSize: 24,
                          fontWeight: FontWeight.w500
                      ),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}