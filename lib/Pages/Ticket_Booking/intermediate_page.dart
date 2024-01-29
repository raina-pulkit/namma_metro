import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class IntermediatePage extends StatefulWidget {
  final String source, destination;
  final bool change;
  final double fare;
  const IntermediatePage({
    super.key,
    required this.source,
    required this.destination,
    required this.change,
    required this.fare
  });

  @override
  State<IntermediatePage> createState() => _IntermediatePageState();
}

class _IntermediatePageState extends State<IntermediatePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Confirm your Ticket",
        show: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${widget.source} - ${widget.destination}',
                style: GoogleFonts.rajdhani(
                  fontWeight: FontWeight.bold,
                  fontSize: 30
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),

              Image.asset(
                'images/intermediate.jpg',
                width: double.infinity,
                height: 450,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFFEEEEEE),
                  borderRadius: BorderRadius.circular(35),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Text(
                        'Ticket Details',
                        style: GoogleFonts.rajdhani(
                          fontSize: 30,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // 4 sub-boxes with different texts
                    buildSubBox(widget.source),
                    buildSubBox(widget.destination),
                    buildSubBox(widget.change?"Majestic":"N/A"),
                    buildSubBox("Rs. ${widget.fare}"),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // Center-aligned button with the new color
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add your book ticket logic here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6F60CC), // Button color: 6F60CC
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(35),
                    ),
                  ),
                  child: const Text(
                    'Book Ticket',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildSubBox(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFE0DEDE), // Color: E0DEDE
        borderRadius: BorderRadius.circular(25),
      ),
      child: Text(
        text,
        style: GoogleFonts.rajdhani(
          fontSize: 20,
          fontWeight: FontWeight.w600
        ),
      ),
    );
  }
}
