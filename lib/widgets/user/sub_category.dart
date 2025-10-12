import 'package:flutter/material.dart';

class SubCategoryTab extends StatelessWidget {
  final List<String> subCategories;
  final int selectedIndex;
  final ValueChanged<int> onSelected;
  final double height;
  final double separatorWidth;

  const SubCategoryTab({
    super.key,
    required this.subCategories,
    required this.selectedIndex,
    required this.onSelected,
    this.height = 48,
    this.separatorWidth = 24,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
      ),
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 24), // 좌우 여백 넉넉하게
        itemCount: subCategories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 18), // 탭 사이 간격 넉넉하게
        itemBuilder: (context, idx) {
          final selected = selectedIndex == idx;
          return GestureDetector(
            onTap: () => onSelected(idx),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  subCategories[idx],
                  style: TextStyle(
                    fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 16,
                    color: selected ? Colors.black : const Color(0xFFBDBDBD),
                  ),
                ),
                const SizedBox(height: 6),
                // 밑줄 제거
              ],
            ),
          );
        },
      ),
    );
  }
}
