import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/Home/first_last_metro.dart';
import 'package:namma_metro/Pages/Ticket_Booking/plan_your_journey.dart';
import 'package:namma_metro/Pages/Home/station_facilities.dart';
import 'package:namma_metro/Pages/Home/time_table.dart';
import 'package:namma_metro/Pages/Profile_Menu/smartcard_recharge.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';
import '../Metro_Lines/metro_lines.dart';
import 'other_info.dart';
import 'tour_guide.dart';
import '../Ticket_Booking/book_qr_ticket.dart';
import 'evacuation_guidelines.dart';
import '../Ticket_Booking/fare_calculator.dart';
import 'lost_found.dart';

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double boxHeight = 150.0; // Declare boxHeight as a class member
  double spacingBetweenBoxes = 20.0; // Set your desired spacing

  late final Future<String> userName;

  @override
  void initState() {
    super.initState();
    userName = getData();
  }

  Future<String> getData() async{
    try{
      DocumentSnapshot res = await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      Map<String, dynamic>? data = res.data() as Map<String, dynamic>?;
      return data?["user_name"] ?? "";
    }
    catch(e){
      return "Again";
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;
    double boxWidthPercentage = 0.8; // Set your desired percentage

    double boxWidth = screenWidth * boxWidthPercentage;

    return FutureBuilder<String>(
        future: userName,
        builder: (context, snapShot){
          if(snapShot.connectionState == ConnectionState.waiting){
            return const Center(
              child: SizedBox(
                height: 30,
                width: 30,
                child: CircularProgressIndicator(),
              ),
            );
          }
          else if(snapShot.hasError){
            return Text("Error: ${snapShot.error}");
          }
          else{
            String userName = snapShot.data ?? "again";

            return Scaffold(
              backgroundColor: Colors.white,
              appBar: CustomTopAppBar(
                text: "Welcome,\n$userName!",
                show: false,
                context: context,
              ),
              body: SingleChildScrollView(
                // padding: EdgeInsets.symmetric(ver),
                child: Column(
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
              ),
            );
          }
        }
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
              builder: (context) => const SmartCardRecharge()
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
                builder: (context) => OtherInfo()
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
    return Container(
      width: width,
      height: height*2,
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
              "Map",
              style: GoogleFonts.rajdhani(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
              )
          ),
          const SizedBox(height: 12.0),
          Image.asset(
            "images/namma_metro_map.png",
            height: 200,
            width: 500,
            fit: BoxFit.cover,
          ),
        ],
      ),
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