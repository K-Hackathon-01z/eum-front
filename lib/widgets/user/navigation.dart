import 'package:flutter/material.dart';

class CustomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomNavigationBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [Icons.home, Icons.map, Icons.explore, Icons.person];
    //final List<String> labels = ['홈', '지도', '내 정보', '탐색'];

    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(icons.length, (index) {
          final isSelected = currentIndex == index;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12), // 좌우 간격 추가
            child: GestureDetector(
              onTap: () => onTap(index),
              behavior: HitTestBehavior.opaque,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icons[index], size: 32, color: isSelected ? Colors.black : Colors.black26),
                  const SizedBox(height: 4),
                  /*Text(
                    labels[index],
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? Colors.black : Colors.black26,
                    ),
                  ),*/
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
