import 'package:flutter/material.dart';

class SkillDetailScreen extends StatelessWidget {
  final String category;
  final List<String>? items; // DB 연동 시 null 가능

  const SkillDetailScreen({Key? key, required this.category, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category 상세'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF1F1F1),
      body: items == null || items!.isEmpty
          ? Center(child: Text('데이터가 없습니다'))
          : ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: items!.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)],
                  ),
                  child: Text(items![idx], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                );
              },
            ),
    );
  }
}
