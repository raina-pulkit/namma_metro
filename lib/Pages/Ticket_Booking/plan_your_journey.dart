import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class PlanYourJourney extends StatefulWidget {
  final bool show;
  final String title;
  const PlanYourJourney({super.key, required this.show, required this.title});

  @override
  State<PlanYourJourney> createState() => _PlanYourJourneyState();
}

class _PlanYourJourneyState extends State<PlanYourJourney> {

  // Selected values for the dropdowns
  late String selectedDeparture;
  late String selectedDestination;

  // Dropdown options
  List<String> departureOptions =  [
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
  List<String> destinationOptions = [
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

  // Date and Time
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();

  final dateController = TextEditingController();
  final timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    selectedDeparture = departureOptions[0];
    selectedDestination = destinationOptions[0];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateController.text = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if ((picked != null) && (picked != selectedTime)) {
      setState(() {
        selectedTime = picked;
        timeController.text = '${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? "AM" : "PM"}';
      });
    }
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

  Widget buildDateTimeBox(String label, TextEditingController controller, Function(BuildContext) selectCallback, double width) {
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
              )
          ),
          const SizedBox(height: 8.0),
          GestureDetector(
            onTap: () => selectCallback(context),
            child: AbsorbPointer(
              child: TextFormField(
                controller: controller,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Tap to select',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildShowRouteButton() {
    return ElevatedButton(
      onPressed: () {
        // Implement your logic when the button is pressed
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF6F60CC), // 6F60CC
      ),
      child: Text(
        'Show Route & Fare',
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
      selectedDeparture = destinationOptions[0];
      selectedDestination = destinationOptions[0];
      selectedDate = DateTime.now();
      selectedTime = TimeOfDay.now();
      dateController.text = '${selectedDate.day}/${selectedDate.month}/${selectedDate.year}';
      timeController.text = '${selectedTime.hour}:${selectedTime.minute} ${selectedTime.period == DayPeriod.am ? "AM" : "PM"}';
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: CustomTopAppBar(
        text: widget.title,
        show: widget.show,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildDropdownBox('Depart From', selectedDeparture, departureOptions, screenWidth),
              const SizedBox(height: 2.0),
              buildDropdownBox('Destination', selectedDestination, destinationOptions, screenWidth),
              const SizedBox(height: 2.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  buildDateTimeBox('Select Date', dateController, _selectDate, screenWidth * 0.4),
                  buildDateTimeBox('Select Time', timeController, _selectTime, screenWidth * 0.4),
                ],
              ),
              const SizedBox(height: 16.0),
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
      ),
    );
  }
}