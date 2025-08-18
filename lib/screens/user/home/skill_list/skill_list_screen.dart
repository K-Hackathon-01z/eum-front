import 'package:flutter/material.dart';
import '../../../../widgets/user/appbar.dart';
import '../../../../widgets/user/skill_list.dart';
import 'skill_detail_screen.dart';

class SkillListScreen extends StatelessWidget {
  const SkillListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: CustomAppBar(
        title: '전통 기술 목록',
        showBack: true,
        showHome: true,
        showSearch: true,
        onSearch: () {
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
        ],
      ),
    );
  }
}
