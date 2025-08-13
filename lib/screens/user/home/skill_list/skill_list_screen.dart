import 'package:flutter/material.dart';
import '../../../../widgets/user/skill_list.dart';
import 'skill_detail_screen.dart';

class SkillListScreen extends StatelessWidget {
  const SkillListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFF1F1F1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '전통 기술 목록',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -1.2),
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
        children: [
          SkillList(
            title: '공예',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SkillDetailScreen(category: '공예')));
            },
          ),
          SkillList(
            title: '섬유',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SkillDetailScreen(category: '섬유')));
            },
          ),
          SkillList(
            title: '식문화',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SkillDetailScreen(category: '식문화')));
            },
          ),
          SkillList(
            title: '예술',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SkillDetailScreen(category: '예술')));
            },
          ),
          SkillList(
            title: '기타',
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SkillDetailScreen(category: '기타')));
            },
          ),
          // SkillList(title: '금속'),
          // SkillList(title: '나전 칠기'),
          // SkillList(title: '도자기'),
          // SkillList(title: '매듭장'),
          // SkillList(title: '칠장'),
          // SkillList(title: '한지'),
          // SkillList(title: '홍염장'),
          // SkillList(title: '한복장'),
          // SkillList(title: '자수'),
          // SkillList(title: '매듭'),
          // SkillList(title: '전통주'),
          // SkillList(title: '장'),
          // SkillList(title: '다과'),
          // SkillList(title: '판소리'),
          // SkillList(title: '민요'),
          // SkillList(title: '탈춤'),
          // SkillList(title: '무용'),
          // SkillList(title: '단청장'),
          // SkillList(title: '소목장'),
        ],
      ),
    );
  }
}
