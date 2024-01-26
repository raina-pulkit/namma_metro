import 'package:flutter/material.dart';

class Ticket extends StatelessWidget {
  const Ticket({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 300,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Second()),
                );
              },
              child: const Text("Next"),
          ),
          ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Back")),
        ],
      ),
    );
  }
}

class Second extends StatelessWidget{
  const Second({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 400,
      height: 300,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("CONTETETSTS"),
            ElevatedButton(onPressed: () => Navigator.pop(context), child: const Text("Back")),
          ],
        ),
      ),
    );
  }

}
