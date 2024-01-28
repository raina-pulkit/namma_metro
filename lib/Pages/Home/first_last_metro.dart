import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class FirstLastMetro extends StatelessWidget {
  const FirstLastMetro({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "First & Last Metro",
        show: true,
        context: context,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Purple Line Section
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 30,),
                  Text(
                    'Purple Line',
                    style: GoogleFonts.rajdhani(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 300, 
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Whitefield',
                          style: GoogleFonts.rajdhani(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('First Metro: 5:00 a.m'),
                        const Text('Last Metro: 22:45 p.m'),
                        const SizedBox(height: 16),
                        Text(
                          'Challaghatta',
                          style: GoogleFonts.rajdhani(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('First Metro: 5:00 a.m'),
                        const Text('Last Metro: 23:05 p.m'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Green Line Section
            SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  Text(
                    'Green Line',
                    style: GoogleFonts.rajdhani(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    width: 300, 
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFEEEEEE),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Nagasandra',
                          style: GoogleFonts.rajdhani(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('First Metro: 5:00 a.m'),
                        const Text('Last Metro: 23:05 p.m'),
                        const SizedBox(height: 16),
                        Text(
                          'Silk Route',
                          style: GoogleFonts.rajdhani(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text('First Metro: 5:00 a.m'),
                        const Text('Last Metro: 23:05 p.m'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
