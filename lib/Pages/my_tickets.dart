import 'package:flutter/material.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class MyTickets extends StatefulWidget {
  const MyTickets({super.key});

  @override
  State<MyTickets> createState() => _MyTicketsState();
}

class _MyTicketsState extends State<MyTickets> {
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
