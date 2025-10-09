import 'skill_detail.dart';
import 'package:flutter/material.dart';

class SkillList extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const SkillList({super.key, this.title = '기술명', this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            showDialog(
              context: context,
              builder: (_) =>
                  SkillDetail(name: title, category: '분류 예시', description: '설명 예시', careerPath: '진로 예시', image_url: ''),
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
            // Container(
            //   width: 65,
            //   height: 55,
            //   margin: const EdgeInsets.only(left: 17, right: 16),
            //   decoration: BoxDecoration(color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(10)),
            // ),
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 32.0), // 왼쪽 여백 추가
                  child: Text(
                    title,
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
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
