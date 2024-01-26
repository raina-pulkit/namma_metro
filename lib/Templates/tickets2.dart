import 'package:flutter/material.dart';

class Ticket extends StatelessWidget {
  const Ticket({super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const Second()),
          );
        },
        child: const Text("Next"),
    );
  }
}

class Second extends StatelessWidget{
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text("CONTETETSTS");
  }

}
