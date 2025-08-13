import 'package:flutter/material.dart';
import '../../../../widgets/user/skill_list.dart';

class SkillDetailScreen extends StatelessWidget {
  final String category;
  final List<String>? items; // DB 연동 시 null 가능

  const SkillDetailScreen({Key? key, required this.category, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 카테고리별 하위 리스트 정의
    final Map<String, List<String>> subSkills = {
      '공예': ['금속', '나전 칠기', '도자기', '매듭장', '칠장', '한지'],
      '섬유': ['홍염장', '한복장', '자수', '매듭'],
      '식문화': ['전통주', '장', '다과'],
      '예술': ['판소리', '민요', '탈춤', '무용'],
      '기타': ['단청장', '소목장'],
    };
    final List<String> skills = subSkills[category] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFF1F1F1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          '$category 목록',
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -1.2),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 32),
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.2),
                builder: (context) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.black54),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(hintText: '검색어를 입력하세요', border: InputBorder.none),
                              ),
                            ),
                            IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[500], height: 1.0),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: skills.map((s) => SkillList(title: s)).toList(),
      ),
    );
  }
}
