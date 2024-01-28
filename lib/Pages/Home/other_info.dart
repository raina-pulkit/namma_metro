import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';


final Uri _phone_number = Uri(
  scheme: 'tel',
  path: '1800-425-12345',
);

class OtherInfo extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  OtherInfo({super.key});

  Future<void> _launchURL(Uri s) async{
    try{
      await launchUrl(s);
    }
    catch(e){
      _showSnackBar("$e \nAn error occurred! Try again!");
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomTopAppBar(
        text: "Other Information",
        show: true,
        context: context,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildInfoBoxWithTap('Namma Metro Helpline', '1800-425-12345'),
              const SizedBox(height: 16),
              buildInfoBoxWithIcon('Namma Metro Network', Icons.directions_railway,
                  'Purple Line\nGreen Line'),
              const SizedBox(height: 16),
              buildInfoBox('Railway Stations Near to Metro',
                  'Krishnarajapuram Railway Station:\nNearest Metro Station: Baiyappanahalli Metro Station\n\n'
                  'Yeshvantpur Junction:\nNearest Metro Station: Yeshwantpur Metro Station\n\n'
                  'Bangalore City Junction (SBC):\nNearest Metro Station: Kempegowda Metro Station (Majestic)\n\n'
                  'Yesvantpur Junction:\nNearest Metro Station: Yeshwantpur Metro Station\n\n'
                  'Bangalore Cantonment (BNC):\nNearest Metro Station: Shivajinagar Metro Station\n\n'),
              const SizedBox(height: 16),
              buildInfoBox('General Information on Bengaluru',
                  'Police:\nEmergency Number: 100\n\nFire Services:\nEmergency Number: 101\n\nAmbulance:\nEmergency Number: 108\n\nWomen\'s Helpline:\nEmergency Number: 1091\n\nChild Helpline:\nEmergency Number: 1098\n\nSenior Citizens Helpline:\nHelpline Number: 1090\n\nTraffic Police:\nHelpline Number: 103\n\nBengaluru City Corporation Helpline:\nHelpline Number: 1912'),
              const SizedBox(height: 16),
              buildInfoBoxWithIcon('Namma Metro Website', Icons.web, 'https://english.bmrc.co.in/'),
            ],
          ),
        ),
      ),
    );
  }


  Widget buildInfoBox(String headline, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            headline,
            style: GoogleFonts.rajdhani(
              fontSize: 30,
              fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            textAlign: TextAlign.left,
            style: GoogleFonts.rajdhani(
              fontWeight: FontWeight.w500,
              fontSize: 20
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoBoxWithIcon(String headline, IconData icon, String line) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon),
              const SizedBox(width: 8),
              Text(
                headline,
                style: GoogleFonts.rajdhani(
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            line,
            textAlign: TextAlign.center,
            style: GoogleFonts.rajdhani(
              fontSize: 20,
              fontWeight: FontWeight.w500
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoBoxWithTap(String headline, String text) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            headline,
            style: GoogleFonts.rajdhani(
                fontSize: 30,
                fontWeight: FontWeight.bold
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => _launchURL(_phone_number),
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: GoogleFonts.rajdhani(
                  fontWeight: FontWeight.w500,
                  fontSize: 20
              ),
            ),
          ),
        ],
      ),
    );
  }
}
