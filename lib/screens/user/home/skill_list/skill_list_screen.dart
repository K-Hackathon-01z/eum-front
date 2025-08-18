import 'skill_detail_screen.dart';
import 'package:flutter/material.dart';
import '../../../../widgets/user/appbar.dart';
import '../../../../widgets/user/skill_list.dart';
import '../../../../services/user/skill_service.dart';
import 'package:eum_demo/models/skill_list/skill_category.dart';

class SkillListScreen extends StatelessWidget {
  const SkillListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SkillService skillService = SkillService();
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
      body: FutureBuilder<List<SkillCategory>>(
        future: skillService.fetchAllSkillCategoriesParsed(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('데이터를 불러올 수 없습니다'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('기술 정보가 없습니다'));
          }
          final skills = snapshot.data!;
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            itemCount: skills.length,
            itemBuilder: (context, idx) {
              final skill = skills[idx];
              return SkillList(
                title: skill.name,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => SkillDetailScreen(category: skill.category)),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
