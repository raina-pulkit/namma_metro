import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class GreenLine extends StatefulWidget {
  const GreenLine({super.key});

  @override
  State<GreenLine> createState() => _GreenLineState();
}

class _GreenLineState extends State<GreenLine> {
  final List<String> stations = [
    "Nagasandra",
    "Dasarahalli",
    "Jalahalli",
    "Peenya Industry",
    "Peenya",
    "Goraguntepalya",
    "Yeshwanthpura",
    "Sandal Soap Factor",
    "Mahalakshmi",
    "Rajajinagar",
    "Kuvempu Road",
    "Srirampur",
    "Sampige Road",
    "Majestic",
    "Chikkapete",
    "KR Market",
    "National College",
    "Lalbagh Botanical Garden",
    "South End Circle",
    "Jayanagar",
    "RV Road",
    "Banashankari",
    "JP Nagar",
    "Yelachenahalli",
    "Konanakunte Cross",
    "Doddakallasandra",
    "Vajarahalli",
    "Talaghattapura",
    "Silk Institute",
  ];

  Widget lineMaker(String stn, int index){
    return Card(
      color: CupertinoColors.systemGreen,
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
