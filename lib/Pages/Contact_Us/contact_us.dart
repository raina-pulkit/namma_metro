import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri phoneNumber = Uri(
  scheme: 'tel',
  path: '+919113289540',
);

String? encodeQueryParameters(Map<String, String> params) {
  return params.entries
      .map((MapEntry<String, String> e) =>
  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
      .join('&');
}

final Uri _email = Uri(
  scheme: 'mailto',
  path: 'pulkitraina2608@gmail.com',
  query: encodeQueryParameters(<String, String>{
    'subject': 'Example Subject & Symbols are allowed!',
  }),
);

final Uri tollFree = Uri.parse("tel:+91-9113289540");

class ContactPage extends StatefulWidget {
  final bool show;
  const ContactPage({super.key, required this.show});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
      appBar: CustomTopAppBar(text: 'Contact Us', show: widget.show, context: context,),
      body: Scaffold(
        backgroundColor: Colors.white,
        extendBody: true,
        key: _scaffoldKey,
        body: Center(
          child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    Image.asset(
                      'images/contact.png',
                      height: 300,
                      width: 300,
                    ),
                    Container(
                      height: 200,
                      width: 350,
                      decoration: const BoxDecoration(
                        color: Color(0xFFEEEEEE),
                        borderRadius: BorderRadius.all(Radius.circular(20)),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () => _launchURL(phoneNumber),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.phone_callback),
                                const SizedBox(width: 10,),
                                Text(
                                  "Phone: +91-123456789",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800
                                  ),
                                  softWrap: true,
                                )
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () => _launchURL(_email),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.email),
                                const SizedBox(width: 10,),
                                Text(
                                  "Email: nammametro@bmrc.co.in",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800
                                  ),
                                  softWrap: true,
                                )
                              ],
                            ),
                          ),

                          GestureDetector(
                            onTap: () => _launchURL(tollFree),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const Icon(Icons.phone_in_talk),
                                const SizedBox(width: 10,),
                                Text(
                                  "Toll-Free: 1800-425-12345",
                                  style: GoogleFonts.rajdhani(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w800
                                  ),
                                  softWrap: true,
                                ),
                              ],
                            ),
                          )
                        ],
                      ),

                    )
                  ],
                );
              }
          ),
        ),
      ),
    );
  }
}


