import 'package:flutter/material.dart';
import '../../../../widgets/user/appbar.dart';
import '../../../../widgets/user/skill_list.dart';
import '../../../../widgets/user/skill_detail.dart';
import 'package:eum_demo/models/skill_list/skill_category.dart';
import '../../../../services/user/skill_service.dart';

class SkillDetailScreen extends StatelessWidget {
  final String category;
  const SkillDetailScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final SkillService skillService = SkillService();
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: CustomAppBar(
        title: '$category 목록',
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
          final skills = snapshot.data!.where((s) => s.category == category).toList();
          if (skills.isEmpty) {
            return const Center(child: Text('해당 카테고리의 기술이 없습니다'));
          }
          return ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
            itemCount: skills.length,
            itemBuilder: (context, idx) {
              final skill = skills[idx];
              return SkillList(
                title: skill.name,
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) => SkillDetail(
                      name: skill.name,
                      category: skill.category,
                      description: skill.description,
                      careerPath: skill.careerPath ?? '',
                    ),
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
