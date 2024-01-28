import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/Home/palette.dart';
import 'package:namma_metro/Pages/Home/pizza.dart';
import 'package:namma_metro/Pages/Home/plan_your_journey.dart';
import 'package:namma_metro/Pages/Home/run.dart';
import 'package:namma_metro/Pages/Home/station_facilities.dart';
import 'package:namma_metro/Pages/Home/time_table.dart';
import 'package:namma_metro/Pages/Home/top_up.dart';
import 'package:namma_metro/Pages/Home/tour_guide.dart';
import 'package:namma_metro/Pages/Home/train.dart';
import 'package:namma_metro/Pages/color.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

import '../Metro_Lines/metro_lines.dart';
import 'beach.dart';
import 'book_qr_ticket.dart';
import 'evacuation_guidelines.dart';
import 'fare_calculator.dart';
import 'first_last_metro.dart';
import 'lost_found.dart';
import 'other_info.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double boxHeight = 150.0; // Declare boxHeight as a class member
  double spacingBetweenBoxes = 20.0; // Set your desired spacing

  dynamic userName;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidthPercentage = 0.8; // Set your desired percentage

    double boxWidth = screenWidth * boxWidthPercentage;

    return Scaffold(
      backgroundColor: primary,
      appBar: CustomTopAppBar(
        text: "Welcome,\nPulkit Raina!",
        show: false,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20,),
                _buildIconBox1(boxWidth, boxHeight),
                SizedBox(height: spacingBetweenBoxes),
                _buildIconBox2(boxWidth, boxHeight),
                SizedBox(height: spacingBetweenBoxes),
                _buildIconBox3(boxWidth, boxHeight),
                SizedBox(height: spacingBetweenBoxes),
                _buildIconBox4(boxWidth, boxHeight),
                // Add other widgets below the icon boxes if needed
              ],
            ),
          ]
        ),
      ),
    );
  }

  Widget _buildIconBox1(double width, double height) {
    return _buildIconBox(
      width,
      height,
      'Metro Services',
      [
        _buildIconWithLabel(Icons.train, 'Plan your\nJourney', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const PlanYourJourney()
            )
          );
        }),
        _buildIconWithLabel(Icons.qr_code, 'Book QR\nTicket', () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const BookQRTicket()
            )
          );
        }),
        _buildIconWithLabel(Icons.add_card, 'Top Up', () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TopUP()
            )
          );
        }),
        _buildIconWithLabel(Icons.calculate_rounded, 'Fare\nCalculator', () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const FareCalculator()
            )
          );
        }),
      ],
    );
  }

  Widget _buildIconBox2(double width, double height) {
    return _buildIconBox(
      width,
      height,
      'Other Services',
      [
        _buildIconWithLabel(Icons.map_sharp, 'Tour\nGuide', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const TourGuide()
            )
          );
        }),
        _buildIconWithLabel(Icons.perm_device_information, 'Other\nInfo', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const OtherInfo()
            )
          );
        }),
        _buildIconWithLabel(Icons.add_road, 'Metro\nLines', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const MetroLines()));
        }),
        _buildIconWithLabel(Icons.calendar_month_rounded, 'Time\nTable', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TimeTable()));
        }),
        _buildIconWithLabel(Icons.directions_train_outlined, 'First &\nLast Metro', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const FirstLastMetro()));
        }),
      ],
    );
  }

  Widget _buildIconBox3(double width, double height) {
    return _buildIconBox(
      width,
      height,
      'Important Information',
      [
        _buildIconWithLabel(Icons.directions_run, 'Evacuation\nGuidelines', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const EvacuationGuidelines()));
        }),
        _buildIconWithLabel(Icons.block_rounded, 'Lost &\nFound', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LostFound()));
        }),
        _buildIconWithLabel(Icons.house_rounded, 'Station\nFacilities', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const StationFacilities()));
        }),
      ],
    );
  }

  Widget _buildIconBox4(double width, double height) {
    return _buildIconBox(
      width,
      height,
      'Map',
      [
        _buildIconWithLabel(Icons.local_pizza, 'Pizza', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PizzaScreen()));
        }),
        _buildIconWithLabel(Icons.directions_run, 'Run', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const RunScreen()));
        }),
        _buildIconWithLabel(Icons.palette, 'Palette', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const PaletteScreen()));
        }),
        _buildIconWithLabel(Icons.beach_access, 'Beach', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const BeachScreen()));
        }),
        _buildIconWithLabel(Icons.train, 'Train', () {
          // Navigate to desired page when icon is clicked
          Navigator.push(context, MaterialPageRoute(builder: (context) => const TrainScreen()));
        }),
      ],
    );
  }

  Widget _buildIconBox(double width, double height, String label, List<Widget> icons) {
    return Container(
      width: width,
      height: height,
      margin: EdgeInsets.symmetric(
        horizontal: (MediaQuery.of(context).size.width - width) / 2
      ),
      padding: const EdgeInsets.all(16.0),
      decoration: const BoxDecoration(
        color: Color(0xFFEEEEEE),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomRight: Radius.circular(20)
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.rajdhani(
              fontSize: 20,
              fontWeight: FontWeight.bold
            )
          ),
          const SizedBox(height: 12.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: icons,
          ),
        ],
      ),
    );
  }

  Widget _buildIconWithLabel(IconData icon, String label, VoidCallback onPressed) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: const Color(0xFF7400E8),
            size: 32.0), // Increased icon size
          const SizedBox(height: 8.0),
          Text(
            label,
            style: GoogleFonts.rajdhani(
              fontSize: 15,
              fontWeight: FontWeight.w600
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}