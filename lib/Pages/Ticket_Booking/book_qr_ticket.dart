import 'package:flutter/material.dart';

class BookQRTicket extends StatelessWidget {
  const BookQRTicket({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book QR Ticket'),
      ),
      body: const Center(
        child: Text('Book QR Ticket'),
      ),
    );
  }
}