import 'package:flutter/material.dart';

class CreatorDetailScreen extends StatelessWidget {
  final String creatorName;
  final List<String>? works; // DB 연동 시 null 가능

  const CreatorDetailScreen({Key? key, required this.creatorName, this.works}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$creatorName 상세'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      backgroundColor: const Color(0xFFF1F1F1),
      body: works == null || works!.isEmpty
          ? Center(child: Text('작품 정보가 없습니다'))
          : ListView.separated(
              padding: const EdgeInsets.all(24),
              itemCount: works!.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, idx) {
                return Container(
                  padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4)],
                  ),
                  child: Text(works![idx], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                );
              },
            ),
    );
  }
}
