import 'package:flutter/material.dart';
import '../../../../widgets/user/creator_list.dart';

class CreatorProfileScreen extends StatelessWidget {
  final String subCategory;
  const CreatorProfileScreen({Key? key, required this.subCategory}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 더미 데이터: 하위카테고리별 장인 리스트
    final Map<String, List<String>> artisanMap = {
      '금속': ['이철수', '박은영', '김금속', '최장인'],
      '칠기장': ['정칠기', '이칠장'],
      '도예가': ['한도예', '박도자'],
      '매듭장': ['김매듭', '이매듭'],
      '한지장': ['최한지', '박한지'],
      // 기타 하위카테고리도 필요시 추가
    };
    final List<String> artisans = artisanMap[subCategory] ?? [];

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
          '$subCategory 장인',
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
        children: artisans.isEmpty
            ? [const Center(child: Text('해당 분야의 장인 정보가 없습니다', style: TextStyle(fontSize: 16)))]
            : artisans.map((name) => CreatorList(title: name)).toList(),
      ),
    );
  }
}
