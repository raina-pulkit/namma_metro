import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class TimeTable extends StatelessWidget {
  const TimeTable({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Time Table",
        show: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: ListView(
          children: const [
            SectionHeading('Weekday Timetable'),
            SizedBox(height: 16),
            TimetableImage('images/weekdayTT1.jpg'),
            SizedBox(height: 8),
            TimetableImage('images/weekdayTT2.jpg'),
            SizedBox(height: 24),
            SectionHeading('Sunday Timetable'),
            SizedBox(height: 16),
            TimetableImage('images/weekendTT1.jpg'),
            SizedBox(height: 24),
            SectionHeading('Government Holiday Timetable'),
            SizedBox(height: 16),
            TimetableImage('images/weekendTT2.jpg'),
          ],
        ),
      ),
    );
  }
}

class SectionHeading extends StatelessWidget {
  final String heading;

  const SectionHeading(this.heading, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      heading,
      textAlign: TextAlign.center,
      style: GoogleFonts.rajdhani(
        fontSize: 24,
        fontWeight: FontWeight.bold
      ),
    );
  }
}

class TimetableImage extends StatelessWidget {
  final String imagePath;

  const TimetableImage(this.imagePath, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: Image.asset(
        imagePath,
        fit: BoxFit.contain,
      ),
    );
  }
}
