import 'package:flutter/material.dart';
import '../../../../widgets/user/appbar.dart';
import '../../../../widgets/user/creator_list.dart';
import 'creator_profile_screen.dart';

class CreatorDetailScreen extends StatelessWidget {
  final String category;
  final List<String>? items; // DB 연동 시 null 가능

  const CreatorDetailScreen({super.key, required this.category, this.items});

  @override
  Widget build(BuildContext context) {
    // 카테고리별 하위 크리에이터 리스트 정의
    final Map<String, List<String>> subCreators = {
      '공예': ['금속', '나전 칠기', '도자기', '매듭장', '칠장', '한지'],
      '섬유': ['홍염장', '한복장', '자수', '매듭'],
      '식문화': ['전통주', '장', '다과'],
      '예술': ['판소리', '민요', '탈춤', '무용'],
      '기타': ['단청장', '소목장'],
    };
    final List<String> creators = subCreators[category] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: CustomAppBar(
        title: category,
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
        children: creators
            .map(
              (c) => CreatorList(
                title: c,
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (_) => CreatorProfileScreen(subCategory: c)));
                },
              ),
            )
            .toList(),
      ),
    );
  }
}
