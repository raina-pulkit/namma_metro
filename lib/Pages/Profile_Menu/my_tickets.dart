import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class MyTickets extends StatefulWidget {
  const MyTickets({super.key});

  @override
  State<MyTickets> createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  final _fs = FirebaseFirestore.instance;
  late final String uid;

  @override
  void initState(){
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.initState();
  }
  Future<List<List<Map<String, dynamic>>>>? getTrans() async{
    List<Map<String, dynamic>> mpp1;
    List<Map<String, dynamic>> mpp2;
    List<List<Map<String, dynamic>>> comb = [];

    await _fs.collection("transaction_history").where("user_id", isEqualTo: uid).get()
        .then((qs) {
      mpp1 = qs.docs
          .map((doc) => doc.data())
          .toList();
      comb.add(mpp1);
    });

    await _fs.collection("tickets").where("user_id", isEqualTo: uid).get()
        .then((qs) {
      mpp2 = qs.docs
          .map((doc) => doc.data())
          .toList();
      comb.add(mpp2);
    });

    return comb;
  }

  Widget lineMaker(double amt, String source, String dest, Timestamp dt){
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
          "$source to $dest",
          style: GoogleFonts.rajdhani(
              fontSize: 25,
              fontWeight: FontWeight.w700,
              color: Colors.black
          ),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                "Rs. $amt",
                style: GoogleFonts.rajdhani(
                  fontSize: 20,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Text(
                "${dt.toDate()}",
                style: GoogleFonts.rajdhani(
                    fontSize: 20,
                    fontWeight: FontWeight.w600
                ),
              ),
            )
          ],
        ),
        leading: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.black54
          ),
          child: const Icon(Icons.mode_of_travel, color: Colors.white, size: 20,),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Ticket History",
        show: true,
        context: context,
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 40),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('tickets').where("user_id", isEqualTo: uid).snapshots(),

          builder: (context, snapshot) {
            if(snapshot.hasData){
              final clients = snapshot.data!.docs.reversed.toList();
              return ListView.builder(
                itemCount: clients.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final t = clients[index];
                  final clientWidget = lineMaker(t["trans_amount"], t["source_station"], t["destination_station"], t["date_and_time"]);
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
      ),
    );
  }
}
