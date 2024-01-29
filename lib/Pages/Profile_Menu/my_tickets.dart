import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class MyTickets extends StatefulWidget {
  const MyTickets({super.key});

  @override
  State<MyTickets> createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
  late final Future<Map<String, String>>? transactions;
  final _fs = FirebaseFirestore.instance;
  late final String uid;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Ticket History",
        show: true,
        context: context,
      ),
    );
  }
}
