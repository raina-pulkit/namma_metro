import 'package:flutter/material.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Account Details",
        show: true,
        context: context,
      ),
    );
  }
}
