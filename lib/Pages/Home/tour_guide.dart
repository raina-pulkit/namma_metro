import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class TourGuide extends StatefulWidget {
  const TourGuide({super.key});

  @override
  State<TourGuide> createState() => _TourGuideState();
}

class _TourGuideState extends State<TourGuide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Tour Guide",
        show: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              buildTopBox('Your own tour guide with all nearest metro station information'),
              const SizedBox(height: 16),
              buildAttractionTable('Purple Line', purpleLineAttractions),
              const SizedBox(height: 32),
              buildAttractionTable('Green Line', greenLineAttractions),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTopBox(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEEEE),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        text,
        style: GoogleFonts.rajdhani(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildAttractionTable(String line, List<Attraction> attractions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          line,
          style: GoogleFonts.rajdhani(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Table(
          border: TableBorder.all(),
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            buildTableRow(['Top Attraction', 'Nearest Station', 'Distance (Km)']),
            for (var attraction in attractions)
              buildTableRow([attraction.name, attraction.station, attraction.distance.toString()]),
          ],
        ),
      ],
    );
  }

  List<Attraction> purpleLineAttractions = [
    Attraction('GT World Mall', 'Magadi Road', 0.5),
    Attraction('Mantri Square Mall', 'Majestic', 1.8),
    Attraction('Karnataka Chitrakala Parishath', 'Majestic', 2.1),
    Attraction('Cubbon Park', 'Vidhana Soudha', 0),
    Attraction('Bangalore Palace', 'Vidhana Soudha', 2.8),
    Attraction('M Chinnaswamy Stadium', 'Cubbon Park', 0.2),
    Attraction('Visvesvaraya Industrial & Technological Museum', 'Cubbon Park', 1),
    Attraction('St Mark’s Cathedral', 'Cubbon Park', 0.7),
    Attraction('Jawaharlal Nehru Planetarium', 'Cubbon Park', 1),
    Attraction('Indira Gandhi Musical Fountain Park', 'Cubbon Park', 0.8),
    Attraction('Racecourse', 'Cubbon Park', 1.9),
    Attraction('St Andrew’s Presbyterian Church', 'Cubbon Park', 0.8),
    Attraction('Commercial Street', 'Cubbon Park', 1.5),
    Attraction('St Mary’s Basilica', 'Cubbon Park', 1.1),
    Attraction('Russell Market', 'Cubbon Park', 1.3),
    Attraction('UB City', 'Cubbon Park', 1.4),
    Attraction('MG Road', 'Mahatma Gandhi Road', 0),
    Attraction('Bangalore One Mall', 'Mahatma Gandhi Road', 0.6),
    Attraction('Brigade Road', 'Mahatma Gandhi Road', 0.2),
    Attraction('1 MG-Lido Mall', 'Trinity', 0.5),
    Attraction('Ulsoor Lake', 'Trinity', 1.9),
    Attraction('St John’s Church', 'Trinity', 1.9),
    Attraction('St Francis Xavier’s Cathedral', 'Trinity', 1.9),
  ];

  List<Attraction> greenLineAttractions = [
    Attraction('Jaya Prakash Narayana Biodiversity Park', 'Yeshwanthpur', 2.4),
    Attraction('Orion Mall', 'Sandal Soap Factory', 0.9),
    Attraction('ISKCON Temple', 'Mahalakshmi', 0.5),
    Attraction('Mantri Square Mall', 'Mantri Square Sampige Road', 0),
    Attraction('Karnataka Chitrakala Parishath', 'Majestic', 2.1),
    Attraction('Cubbon Park', 'Majestic', 3.2),
    Attraction('M Chinnaswamy Stadium', 'Majestic', 3.5),
    Attraction('Visvesvaraya Industrial & Technological Museum', 'Majestic', 3.3),
    Attraction('St. Mark’s Cathedral', 'Majestic', 3.7),
    Attraction('Jawaharlal Nehru Planetarium', 'Majestic', 3.2),
    Attraction('Indira Gandhi Musical Fountain Park', 'Majestic', 3.1),
    Attraction('Racecourse', 'Majestic', 1.8),
    Attraction('Bangalore Fort', 'KR Market', 0.4),
    Attraction('Tipu Sultan’s Summer Palace', 'KR Market', 0.2),
    Attraction('Lalbagh Botanical Garden and Lake', 'Lalbagh', 0),
  ];

  TableRow buildTableRow(List<String> cells) {
    return TableRow(
      children: cells.map((cell) => buildTableCell(cell)).toList(),
    );
  }

  Widget buildTableCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(text, textAlign: TextAlign.center),
    );
  }
}


class Attraction {
  final String name;
  final String station;
  final double distance;

  Attraction(this.name, this.station, this.distance);
}
