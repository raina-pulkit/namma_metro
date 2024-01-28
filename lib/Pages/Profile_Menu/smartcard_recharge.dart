import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:namma_metro/Pages/top_app_bar.dart';

class SmartCardRecharge extends StatefulWidget {
  const SmartCardRecharge({super.key});

  @override
  State<SmartCardRecharge> createState() => _SmartCardRechargeState();
}

class _SmartCardRechargeState extends State<SmartCardRecharge> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomTopAppBar(
        text: "Smartcard Recharge",
        show: true,
        context: context,
      ),
      body: SingleChildScrollView(
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20,),
              Center(
                child: Text(
                  'Recharge Metro Smart Card',
                  style: GoogleFonts.rajdhani(
                    fontSize: 30,
                    fontWeight: FontWeight.bold
                  )
                ),
              ),
              const SizedBox(height: 16),
              buildEditableBox(
                label: 'Card Number',
                controller: cardNumberController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              buildEditableBox(
                label: 'Your Name',
                controller: nameController,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp('[a-zA-Z]')),
                ],
              ),
              buildEditableBox(
                label: 'Amount to be added',
                controller: amountController,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
              ),
              Row(
                children: [
                  buildSmallBox('50', amountController),
                  buildSmallBox('100', amountController),
                  buildSmallBox('200', amountController),
                  buildSmallBox('500', amountController),
                ],
              ),
              const SizedBox(height: 16),
              buildRechargeButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditableBox({
    required String label,
    required TextEditingController controller,
    required List<TextInputFormatter> inputFormatters,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFE0DEDE),
        borderRadius: const BorderRadius.only(topRight: Radius.circular(20), bottomLeft: Radius.circular(20)),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 2,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: GoogleFonts.rajdhani(
              fontSize: 22,
              fontWeight: FontWeight.bold
            )
          ),
          TextField(
            controller: controller,
            inputFormatters: inputFormatters,
            keyboardType: label == 'Your Name'
                ? TextInputType.text
                : TextInputType.number,
            style: GoogleFonts.rajdhani(
              fontWeight: FontWeight.w600
            ),
            decoration: InputDecoration(
              hintText: 'Enter $label',
              hintStyle: const TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildSmallBox(String text, TextEditingController controller) {
    return GestureDetector(
      onTap: () {
        setState(() {
          controller.text = text;
        });
      },
      child: Container(
        width: 70,
        height: 30,
        margin: const EdgeInsets.only(right: 8.0),
        decoration: BoxDecoration(
          color: const Color(0xFFE0DEDE),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 2,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }

  Widget buildRechargeButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Add your recharge logic here
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF6F60CC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            'Recharge',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}