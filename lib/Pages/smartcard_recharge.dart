import 'package:flutter/material.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class SmartCardRecharge extends StatefulWidget {
  const SmartCardRecharge({super.key});

  @override
  State<SmartCardRecharge> createState() => _SmartCardRechargeState();
}

class _SmartCardRechargeState extends State<SmartCardRecharge> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "SmartCard Recharge",
        show: true,
        context: context,
      ),
    );
  }
}
