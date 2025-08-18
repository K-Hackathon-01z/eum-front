import 'package:flutter/material.dart';
import '../../../../widgets/user/appbar.dart';
import '../../../../widgets/user/creator_list.dart';

class CreatorProfileScreen extends StatelessWidget {
  final String subCategory;
  const CreatorProfileScreen({super.key, required this.subCategory});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터: 하위카테고리별 장인 리스트
    final Map<String, List<String>> artisanMap = {
      '금속공예': ['이철수', '박은영', '김금속', '최장인'],
      '나전 칠기': ['정칠기', '이칠장'],
      '도자기': ['한도예', '박도자'],
      '매듭장': ['김매듭', '이매듭'],
      '칠장': ['최칠장', '박칠장'],
      '한지': ['최한지', '박한지'],
    };
    final List<String> artisans = artisanMap[subCategory] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: CustomAppBar(
        title: '$subCategory 장인',
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
        children: artisans.isEmpty
            ? [const Center(child: Text('해당 분야의 장인 정보가 없습니다', style: TextStyle(fontSize: 16)))]
            : artisans.map((name) => CreatorList(title: name)).toList(),
      ),
    );
  }
}
