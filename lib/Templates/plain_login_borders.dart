import 'package:flutter/material.dart';

LinearGradient lgTop() {
  return const LinearGradient(
    colors: <Color>[
      Color(0xff1f005c),
      Color(0xff972f9b),
      Color(0xff941e70),
      Color(0xffac255e),
      Color(0xffca485c),
      Color(0xffe16b5c),
      Color(0xfff39060),
      Color(0xffffb56b),
    ],
  );
}

class LoginBorder extends StatelessWidget{
  final Container cont;
  const LoginBorder({super.key, required this.cont});

  @override
  Widget build(BuildContext context){
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.white60],
        )
      ),
      child: Directionality(
        textDirection: TextDirection.ltr,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 100,
              decoration: BoxDecoration(
                gradient: lgTop(),
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(0),
                    bottom: Radius.circular(20)
                ),
              ),
            ),
            const Spacer(),
            Center(
              child: Container(
                color: Colors.transparent,
                child: cont,
              ),
            ),
            const Spacer(),
            Container(
              height: 80,
              decoration: BoxDecoration(
                gradient: lgTop(),
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(20),
                    bottom: Radius.circular(0)
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}