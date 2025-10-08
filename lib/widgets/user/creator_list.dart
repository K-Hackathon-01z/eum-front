import 'package:flutter/material.dart';
import 'creator_detail.dart';

class CreatorList extends StatelessWidget {
  final String title;
  final String skill;
  final String works;
  final String bio;
  final VoidCallback? onTap;
  final Color? color;

  const CreatorList({
    super.key,
    this.title = '이름',
    this.skill = '기술',
    this.works = '작품',
    this.bio = '약력',
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            showDialog(
              context: context,
              builder: (_) => CreatorDetail(name: title, skill: skill, works: works, bio: bio),
            );
          },
      child: Container(
        height: 80,
        width: double.infinity,
        margin: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: color ?? Colors.white,
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
            ),
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
