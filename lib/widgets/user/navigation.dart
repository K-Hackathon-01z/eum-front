import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
        borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
      ),
      child: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTap,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        elevation: 0,
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black26,
        selectedFontSize: 0, // 라벨 숨김
        unselectedFontSize: 0, // 라벨 숨김
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.map, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.explore, size: 32), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person, size: 32), label: ''),
        ],
      ),
    );
  }
}
