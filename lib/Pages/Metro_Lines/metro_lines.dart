import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/Metro_Lines/coming_up_soon.dart';
import 'package:namma_metro/Pages/Metro_Lines/green_line.dart';
import 'package:namma_metro/Pages/Metro_Lines/purple_line.dart';
import 'package:namma_metro/Pages/color.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class MetroLines extends StatefulWidget {
  const MetroLines({super.key});

  @override
  State<MetroLines> createState() => _MetroLinesState();
}

class _MetroLinesState extends State<MetroLines> {
  final List<String> lines = [
    "Purple Line",
    "Green Line",
    "Yellow Line",
    "Pink Line",
    "Blue Line"
  ];
  final List<Color> cols = [
    primary,
    CupertinoColors.systemGreen,
    CupertinoColors.systemYellow,
    Colors.pinkAccent,
    Colors.blueAccent
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final pages = [
    const PurpleLine(),
    const GreenLine(),
    const ComingSoon(),
    const ComingSoon(),
    const ComingSoon()
  ];

  Widget lineMaker(String stn, Color col, Function onTap){
    return Card(
      color: col,
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
        leading: Container(
          width: 25,
          height: 25,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black54
          ),
          child: const Icon(Icons.circle, color: Colors.white, size: 10,),
        ),
        trailing: const Icon(Icons.arrow_right, color: Colors.black, size: 50,),
        onTap: () => onTap(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        key: _scaffoldKey,
        appBar: CustomTopAppBar(
          text: "Metro Lines",
          show: true,
          context: context,
        ),
        body: ListView.separated(
            itemBuilder: (context, index) => lineMaker(
              lines[index],
              cols[index],
              (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => pages[index]
                  )
                );
              }
            ),
            separatorBuilder: (context, index) => const Divider(),
            itemCount: lines.length
        ),
      ),
    );
  }
}
