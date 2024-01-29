import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class MyCards extends StatefulWidget {
  const MyCards({super.key});

  @override
  State<MyCards> createState() => _MyCardsState();
}

class _MyCardsState extends State<MyCards> {
  late final Future<Map<String, String>>? cardNumbers;
  final _fs = FirebaseFirestore.instance;
  final _fa = FirebaseAuth.instance;
  late final String uid;
  
  Future<Map<String, String>>? getCardNums() async{
    await _fs.collection("metro_cards").where("user_id", isEqualTo: uid).get()
        .then((qs) {
          return qs.docs
              .map((doc) => doc.data())
              .toList();
        });
    return {};
  }

  Widget buildExistingCards(Map<String, String> mpp){
    if(mpp.isEmpty){
      return SizedBox(
        height: 200,
        width: double.infinity,
        child: Center(
          child: Text(
            "No cards yet",
            style: GoogleFonts.rajdhani(
              fontSize: 70,
              fontWeight: FontWeight.bold,
              shadows: [
                const Shadow(
                  color: Colors.black,
                  offset: Offset(2.0, 2.0),
                  blurRadius: 4.0,
                ),
              ]
            ),
          ),
        ),
      );
    }
    else{
      return ListView.builder(
          itemCount: mpp.length,
          itemBuilder: (context, index){
            String key = mpp.keys.elementAt(index);
            String? val = mpp[key];

            return Card(
              child: ListTile(
                title: Text(
                  val!,
                  style: GoogleFonts.rajdhani(
                    fontSize: 24,
                    fontWeight: FontWeight.w600
                  ),
                ),
              ),
            );
          }
      );
    }
  }

  Widget buildAddNewCardButton(){
    return ElevatedButton(
      onPressed: (){
        showDialog(
            context: context,
            builder: (context) {
              return const Placeholder();
            }
        );
      },
      style: ElevatedButton.styleFrom(
          minimumSize: const Size(327, 50),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          elevation: 1,
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 0),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50)),
          )
      ),
      child: Text(
        "Add New Card",
        style: GoogleFonts.rajdhani(
            fontWeight: FontWeight.w600,
            fontSize: 20
        ),
      ),
    );
  }
  
  @override
  void initState(){
    uid = _fa.currentUser!.uid;
    cardNumbers = getCardNums();
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "My Smart Cards",
        show: true,
        context: context,
      ),
      body: Column(
        children: [
          FutureBuilder<Map<String, String>>(
            future: cardNumbers,
            builder: (context, snap) {
              if(snap.connectionState == ConnectionState.waiting){
                return const SizedBox(
                  height: 40,
                  width: 40,
                  child: Center(child: CircularProgressIndicator()),
                );
              }
              else if(snap.hasError){
                return Center(child: Text("Error Occured!", style: GoogleFonts.rajdhani(fontSize: 40, fontWeight: FontWeight.bold),),);
              }
              else{
                var fetchedData = snap.data!;
                return buildExistingCards(fetchedData);
              }
            },
          ),
          const SizedBox(height: 40,),
          buildAddNewCardButton(),
        ],
      ),
    );
  }
}
