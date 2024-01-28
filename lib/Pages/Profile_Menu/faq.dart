import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/peristent_bottom_nav_bar.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class FAQ extends StatefulWidget {
  const FAQ({Key? key}) : super(key: key);

  @override
  State<FAQ> createState() => _FAQState();
}

class Data {
  String question;
  String answer;
  bool isExpanded;

  Data({required this.question, required this.answer, this.isExpanded = false});
}

final questions = [
  "How do I get into the Metro station?",
  "How will I know which way I’m going?",
  "What if I get on the wrong train? Will I have to pay twice over?",
  "How will I know which side the gates of the Metro will open?",
  "What if I overshoot my journey? The gates will not open then.",
  "What if I’m getting in and the door closes? Will I get stuck? Will the train start moving?",
];

final answers = [
  "Buy a Metro card for multiple journeys or a single journey token from the ticket vendors at the concourse level. The security gates have a contactless system—you simply hold the token or ticket close to the reader and the gates open automatically. Make sure you return the single journey token when you are getting out of the station.",
  "Metro systems are very user-friendly. At the platform, direction arrows will tell you which side the train is headed (Baiyappanahalli or MG Road side). Once inside the train, you’ll find all the information above the door. Regular announcements will be made about the next station — you can never miss that.",
  "No. Your entry and exit are recorded by the security gates at the concourse level and not at the platform level. If you get on the wrong train, get down and board the train going in the opposite direction. But make sure you get in and out of the station within a certain time—you can’t loiter around all day.",
  "The information on top of the door will tell you which gate will open next. Also regular announcements like “Gates will open on the right” will guide you.",
  "No worries. Walk up to the Metro assistance booth and pay the difference in fare. The attendant will open a manual gate for you to get out.",
  "Metro doors have sensors pretty much like lift cars do. If an object comes in between the doors, they retract. Moreover, a buzzer will sound seconds before the door is about to close. Do not try to get in when the buzzer starts sounding. The train will not move until all doors are firmly locked, so don’t worry.",
];

class _FAQState extends State<FAQ> {
  final List<Data> data = List<Data>.generate(
    6,
    (index) {
      return Data(question: questions[index], answer: answers[index]);
    },
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(text: "FAQ", show: true, context: context),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: ListView(
          children: [
            ExpansionPanelList(
              elevation: 1,
              // expandedHeaderPadding: const EdgeInsets.all(30),
              expansionCallback: (index, isExpanded) {
                setState(() {
                  data[index].isExpanded = !data[index].isExpanded;
                });
              },
              children: data.map<ExpansionPanel>((Data data) {
                return ExpansionPanel(
                  canTapOnHeader: true,
                  headerBuilder: (BuildContext context, bool isExpanded) {
                    return ListTile(
                      selectedColor: Colors.blue,
                      title: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          gradient: lgBtm(),
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), bottomRight: Radius.circular(20))
                        ),
                        child: Text(
                          data.question,
                          style: GoogleFonts.rajdhani(
                            fontSize: 25,
                            fontWeight: FontWeight.w800,
                            color: Colors.white
                          ),
                        ),
                      ),
                    );
                  },
                  body: ListTile(
                    focusColor: Colors.blue,
                    title: Text(
                      data.answer,
                      style: GoogleFonts.rajdhani(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    tileColor: Colors.grey,
                    contentPadding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
                  ),
                  isExpanded: data.isExpanded,
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
