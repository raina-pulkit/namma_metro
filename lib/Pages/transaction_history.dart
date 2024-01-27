import 'package:flutter/material.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({super.key});

  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Transaction History",
        show: true,
        context: context,
      ),
    );
  }
}
