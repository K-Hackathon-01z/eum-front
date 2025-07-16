import 'package:flutter/material.dart';

class SkillList extends StatelessWidget {
  final String title;
  final String category;
  final String photoLabel;
  final VoidCallback? onTap;

  const SkillList({Key? key, this.title = '기술명', this.category = '카테고리', this.photoLabel = 'Photo', this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            // 왼쪽 회색 아이콘 영역
            Container(
              width: 65,
              height: 55,
              margin: const EdgeInsets.only(left: 17, right: 16),
              decoration: BoxDecoration(color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(10)),
              child: Center(
                child: Text(
                  photoLabel,
                  style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
            ),
            // 가운데 텍스트 영역
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    category,
                    style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black38),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            // 오른쪽 확장 아이콘
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Icon(Icons.chevron_right, size: 24, color: Colors.black.withOpacity(0.5)),
            ),
          ],
        ),
      ),
    );
  }
}
