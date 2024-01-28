import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';


class EvacuationGuidelines extends StatelessWidget {
  const EvacuationGuidelines({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Evacuation Guidelines",
        show: true,
        context: context,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 40),
          Container(
            alignment: Alignment.topCenter,
            child: Text(
              'Evacuation Guidelines',
              style: GoogleFonts.rajdhani(
                fontSize: 35,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEEEE),
              borderRadius: BorderRadius.circular(35),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '•',
                      style: GoogleFonts.rajdhani(
                        fontSize: 20,
                        fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(width: 8), // Space between bullet and text
                    Expanded(
                      child: Text(
                        'Karnataka State Fire and Emergency Services Department: 1902',
                        style: GoogleFonts.rajdhani(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Line space after the point

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '•',
                      style: GoogleFonts.rajdhani(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(width: 8), // Space between bullet and text
                    Expanded(
                      child: Text(
                        'Follow directions from Metro staff. Do not exit train unless directed to do so. It is very dangerous leaving the train on your own.',
                        style: GoogleFonts.rajdhani(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Line space after the point

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '•',
                      style: GoogleFonts.rajdhani(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(width: 8), // Space between bullet and text
                    Expanded(
                      child: Text(
                        'Help children and the mobility impaired. Do not block the exits with bulky items.',
                        style: GoogleFonts.rajdhani(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8), // Line space after the point

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '•',
                      style: GoogleFonts.rajdhani(
                          fontSize: 20,
                          fontWeight: FontWeight.w600
                      ),
                    ),
                    const SizedBox(width: 8), // Space between bullet and text
                    Expanded(
                      child: Text(
                        'Use fire extinguisher only if necessary. If there is smoke, cover your nose and mouth, and try to crouch.',
                        style: GoogleFonts.rajdhani(
                            fontSize: 20,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // You can add more content below the rectangular box as needed
        ],
      ),
    );
  }
}