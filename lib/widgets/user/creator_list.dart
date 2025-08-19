import 'package:flutter/material.dart';
import 'creator_detail.dart';

class CreatorList extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;
  final Color? color;

  const CreatorList({super.key, this.title = '이름', this.onTap, this.color});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            showDialog(
              context: context,
              builder: (_) => CreatorDetail(
                name: title,
                skill: '한지',
                works: '한지의 미학, 빛과 종이의 만남',
                bio: '30년 경력 한지 장인. 대한민국 공예대전 대상, 한지문화제 초대작가 등 다양한 수상 및 전시 경력 보유.',
              ),
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
