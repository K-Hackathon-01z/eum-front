import 'package:flutter/material.dart';
import 'creator_detail.dart';

class CreatorList extends StatelessWidget {
  final String title;
  final String photoLabel;
  final VoidCallback? onTap;

  const CreatorList({super.key, this.title = '이름', this.photoLabel = 'Photo', this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            showDialog(
              context: context,
              builder: (_) => CreatorDetail(name: title, skill: '기술 예시', works: '주요작품 예시', bio: '약력 예시'),
            );
          },
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
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  title,
                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                ),
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
