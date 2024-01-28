import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/color.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class PurpleLine extends StatefulWidget {
  const PurpleLine({super.key});

  @override
  State<PurpleLine> createState() => _PurpleLineState();
}

class _PurpleLineState extends State<PurpleLine> {
  final List<String> stations = [
    "Whitefield",
    "Hopefarm Channasandra",
    "Kadugodi Tree Park",
    "Pattanduru Agrahara",
    "Sri Sathya Sai Hospital",
    "Nallurhalli",
    "Kundanahalli",
    "Seetharampalya",
    "Hoodi",
    "Garudacharapalya",
    "Singayyanapalya",
    "KR Puram",
    "Benniganahalli",
    "Baiyapanahalli",
    "SV Road",
    "Indiranagar",
    "Halasuru",
    "Trinity",
    "MG Road",
    "Cubbon Park",
    "Vidhaan Soudha",
    "Central College",
    "Majestic",
    "City Railway Station",
    "Magadi Road",
    "Hosahalli",
    "Vijayanagara",
    "Attiguppe",
    "Deepanjali Nagar",
    "Mysuru Road",
    "Pantharapalya",
    "Rajarajeshwari Nagar",
    "Jnabharathi",
    "Pattanagere",
    "Kengeri Bus Terminal",
    "Kengeri",
    "Challaghatta"
  ];

  Widget lineMaker(String stn, int index){
    return Card(
      color: primary,
      elevation: 3,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            bottomLeft: Radius.circular(20)
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(
          stn,
          style: GoogleFonts.rajdhani(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.black
          ),
        ),
        subtitle: Text(
          "Station $index",
          style: GoogleFonts.rajdhani(
              fontSize: 20,
              fontWeight: FontWeight.w600
          ),
        ),
        leading: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black54
          ),
          child: const Icon(Icons.circle, color: Colors.white, size: 10,),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomTopAppBar(
          text: "Purple Line Stations",
          show: true,
          context: context,
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => lineMaker(stations[index], index+1),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: stations.length
        )
    );
  }
}
