import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../top_app_bar.dart';

class FareCalculator extends StatefulWidget {
  const FareCalculator({super.key});

  @override
  State<FareCalculator> createState() => _FareCalculatorState();
}

class _FareCalculatorState extends State<FareCalculator> {

  // Selected values for the dropdowns
  late String selectedDeparture;
  late String selectedDestination;

  // Dropdown options
  // mod 39
  List<String> stations =  [
    "Tap to Select",
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
    "Challaghatta",
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

  @override
  void initState() {
    super.initState();
    selectedDeparture = stations[0];
    selectedDestination = stations[0];
  }

  Widget buildDropdownBox(String label, String? selectedValue, List<String?> dropdownOptions, double width) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(16.0),
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.rajdhani(
                fontSize: 18,
                fontWeight: FontWeight.bold
            ),
          ),
          const SizedBox(height: 8.0),
          DropdownButtonFormField<String?>(
            value: selectedValue,
            onChanged: (value) {
              setState(() {
                if (label == 'Depart From') {
                  selectedDeparture = value!;
                } else if (label == 'Destination') {
                  selectedDestination = value!;
                }
              });
            },
            items: dropdownOptions.map((option) {
              return DropdownMenuItem<String?>(
                value: option,
                child: Text(option ?? 'Empty'),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(
      SnackBar(
        content: SizedBox(
          height: 40,
          child: Text(
            message,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        backgroundColor: Colors.red,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  void calcFare() {
    double base = 11;
    double std = 4;
    int first = stations.indexOf(selectedDeparture);
    int second = stations.indexOf(selectedDestination);
    int r1 = first ~/ 38;
    int r2 = second ~/ 38;
    first = first % 39;
    second = second % 39;

    if(((r1 == 0) && (first == 0)) || ((r2 == 0) && (second == 0))){
      _showSnackBar("Please choose both stations!");
    }
    else if(r1 == r2){
      double amt = ((first-second).abs()) * std;
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Total Fare',
              style: GoogleFonts.rajdhani(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),
            content: Text(
                "Rs. ${(amt > base)?amt: base}",
                style: GoogleFonts.rajdhani(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
    else{
      double amt = 0;
      amt += ((first-23).abs()*std);
      amt += ((second - 12).abs()*std);

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Total Fare'),
            content: Text("Rs. {($amt > $base)?$amt: $base}"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  Widget buildShowRouteButton() {
    return ElevatedButton(
      onPressed: () => calcFare(),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6F60CC), // 6F60CC
      ),
      child: Text(
        'Show Fare',
        style: GoogleFonts.rajdhani(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white
        ),
      ),
    );
  }

  Widget buildResetButton() {
    return TextButton(
      onPressed: _resetInputs,
      child: Text(
        'RESET',
        style: GoogleFonts.rajdhani(
            fontSize: 16,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }

  void _resetInputs() {
    setState(() {
      selectedDeparture = stations[0];
      selectedDestination = stations[0];
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      key: _scaffoldKey,
      appBar: CustomTopAppBar(
        text: "Fare Calculator",
        show: true,
        context: context,
      ),
      body: Builder(
        builder: (context) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 100,),
                  buildDropdownBox('Depart From', selectedDeparture, stations, screenWidth),
                  const SizedBox(height: 2.0),
                  buildDropdownBox('Destination', selectedDestination, stations, screenWidth),
                  const SizedBox(height: 2.0),

                  Center(
                    child: buildShowRouteButton(),
                  ),
                  const SizedBox(height: 8.0),
                  Center(
                    child: buildResetButton(),
                  ),
                ],
              ),
            ),
          );
        }
      ),
    );
  }
}

