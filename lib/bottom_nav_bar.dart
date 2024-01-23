import 'package:flutter/material.dart';
LinearGradient lgBtm() {
  return const LinearGradient(
    colors: <Color>[
      Color(0xff1f005c),
      Color(0xff5b0060),
      Color(0xff870160),
      Color(0xffac255e),
      Color(0xffca485c),
      Color(0xffe16b5c),
      Color(0xfff39060),
      Color(0xffffb56b),
    ],
  );
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar({super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: const <BoxShadow>[
            BoxShadow(
              color: Colors.black45,
              blurRadius: 15.0,
              offset: Offset(0.0, 0.75),
            ),
          ],
          gradient: lgBtm(),
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20), bottom: Radius.circular(0)),
          color: const Color.fromRGBO(20, 20, 20, 0.75),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 5.0),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 1000),
          curve: Curves.easeInOutCubic,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: _buildNavItem(icon: Icons.home, label: 'Home', index: 0),),
              Expanded(child: _buildNavItem(icon: Icons.airplane_ticket_outlined, label: 'Tickets', index: 1),),
              Expanded(child: _buildNavItem(icon: Icons.account_circle, label: 'Profile', index: 2),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required IconData icon, required String label, required int index}) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: currentIndex == index ? 50 : 24,
            color: currentIndex == index ? Colors.blue : Colors.white,
          ),
          Text(
            label,
            style: TextStyle(
              color: currentIndex == index ? Colors.blue : Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}