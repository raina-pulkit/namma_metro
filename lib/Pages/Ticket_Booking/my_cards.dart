import 'dart:developer';
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
  final _fs = FirebaseFirestore.instance;
  final _fa = FirebaseAuth.instance;
  late final String uid;
  final TextEditingController txtCtrl = TextEditingController();

  Widget buildAddNewCardButton(){
    return ElevatedButton(
      onPressed: (){
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  "Enter your card number!",
                  style: GoogleFonts.rajdhani(
                    fontSize: 30,
                    fontWeight: FontWeight.w600
                  ),
                ),
                content: SizedBox(
                  height: 120,
                  child: Center(
                    child: TextField(
                      controller: txtCtrl,
                      decoration: const InputDecoration(labelText: "Your metro card number"),
                    ),
                  ),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: (){
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Cancel",
                        style: GoogleFonts.rajdhani(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        String newCard = txtCtrl.text.trim();
                        await _fs.collection("metro_cards").doc().set({
                          "user_id": uid,
                          "metro_card_number": newCard
                        }).then((res){
                          Navigator.pop(context);
                          setState((){});
                        });
                      },
                    child: Text(
                      "Submit",
                      style: GoogleFonts.rajdhani(
                          fontSize: 24,
                          fontWeight: FontWeight.bold
                      ),
                    ),
                  )
                ],
              );
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

  Widget lineMaker(String stn){
    return Card(
      color: const Color(0xFFA89D9D),
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
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black54
          ),
          child: const Icon(Icons.credit_card, color: Colors.white, size: 20,),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.white, size: 20),
          onPressed: () async{
            await _fs.collection("metro_cards").where("user_id", isEqualTo: uid).where("metro_card_number", isEqualTo: stn).get()
              .then((res) {
                if(res.docs.isNotEmpty){
                  res.docs.first.reference.delete()
                  .then((task)  {
                    setState(() {});
                  }).catchError((e) {log(e.toString());});
                }
              });
          },
        ),
      ),
    );
  }
  
  @override
  void initState(){
    uid = _fa.currentUser!.uid;
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
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        child: Column(
          children: [
            StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('metro_cards').where("user_id", isEqualTo: uid).snapshots(),

              builder: (context, snapshot) {
                if(snapshot.hasData){
                  final clients = snapshot.data!.docs.reversed.toList();
                  return ListView.builder(
                    itemCount: clients.length,
                    shrinkWrap: true, // Add this line
                    itemBuilder: (context, index) {
                      final clientWidget = lineMaker(clients[index]['metro_card_number']);
                      return clientWidget;
                    },
                  );
                }
                else{
                  return const SizedBox(
                    height: 60,
                    width: 60,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
              },
            ),
            const SizedBox(height: 40,),
            buildAddNewCardButton(),
          ],
        ),
      ),
    );
  }
}
