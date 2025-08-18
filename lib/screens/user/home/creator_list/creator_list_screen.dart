import 'package:flutter/material.dart';
import '../../../../widgets/user/appbar.dart';
import '../../../../widgets/user/creator_list.dart';
import 'creator_detail_screen.dart';

class CreatorListScreen extends StatelessWidget {
  const CreatorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> categories = [
      {'title': '공예'},
      {'title': '섬유'},
      {'title': '식문화'},
      {'title': '예술'},
      {'title': '기타'},
    ];
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: CustomAppBar(
        title: '장인 기술 분류',
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
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        itemCount: categories.length,
        itemBuilder: (context, idx) {
          final category = categories[idx]['title']!;
          return CreatorList(
            title: category,
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => CreatorDetailScreen(category: category)));
            },
          );
        },
      ),
    );
  }
}
