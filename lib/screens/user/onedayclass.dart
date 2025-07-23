import 'package:flutter/material.dart';

class OnedayClassScreen extends StatefulWidget {
  const OnedayClassScreen({super.key});

  @override
  State<OnedayClassScreen> createState() => _OnedayClassScreenState();
}

class _OnedayClassScreenState extends State<OnedayClassScreen> {
  final List<String> categories = ['인기', '공예', '식문화', '생활', '예술', '기타'];
  int selectedCategory = 0;

  final List<Map<String, String>> classData = [
    {'region': '서울시 광진구', 'desc': '원데이 클래스 상세 설명 최대 40자입니다.\n두 줄까지 입력 가능합니다.', 'price': '52,000원'},
    {'region': '서울시 동대문구', 'desc': '원데이 클래스 상세 설명 최대 40자입니다.\n두 줄까지 입력 가능합니다.', 'price': '30,000원'},
    {'region': '서울시 송파구', 'desc': '원데이 클래스 상세 설명 최대 40자입니다.\n두 줄까지 입력 가능합니다.', 'price': '100,000원'},
    {'region': '서울시 서초구', 'desc': '원데이 클래스 상세 설명 최대 40자입니다.\n두 줄까지 입력 가능합니다.', 'price': '97,000원'},
  ];

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = 32; // 좌우 16씩
    final int categoryCount = categories.length;
    final double minTextWidth = 32; // 카테고리 텍스트의 최소 너비(더 넓은 간격)
    final double separatorWidth =
        (screenWidth - horizontalPadding - (categoryCount * minTextWidth)) / (categoryCount - 1);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '원데이 클래스',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -1.2),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 카테고리 탭
          Container(
            height: 48,
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Color(0xFFE0E0E0), width: 1)),
            ),
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: categories.length,
              separatorBuilder: (_, __) => SizedBox(width: separatorWidth),
              itemBuilder: (context, idx) {
                final selected = selectedCategory == idx;
                return GestureDetector(
                  onTap: () => setState(() => selectedCategory = idx),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        categories[idx],
                        style: TextStyle(
                          fontWeight: selected ? FontWeight.bold : FontWeight.w500,
                          fontSize: 16,
                          color: selected ? Colors.black : const Color(0xFFBDBDBD),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Container(
                        width: 28,
                        height: 3,
                        decoration: BoxDecoration(
                          color: selected ? Colors.black : Colors.transparent,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          // 광고(AD) 배너
          Container(
            width: double.infinity,
            height: 100,
            color: const Color(0xFFD9D9D9),
            alignment: Alignment.center,
            child: const Text(
              'AD',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.black54),
            ),
          ),
          // 클래스 카드 그리드
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: GridView.builder(
                itemCount: classData.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 18,
                  crossAxisSpacing: 18,
                  childAspectRatio: 0.5,
                ),
                itemBuilder: (context, idx) {
                  final data = classData[idx];
                  return Container(
                    decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(24)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                LayoutBuilder(
                                  builder: (context, constraints) {
                                    final double size = constraints.maxWidth;
                                    return Container(
                                      width: size,
                                      height: size,
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFD9D9D9),
                                        borderRadius: BorderRadius.circular(18),
                                      ),
                                      alignment: Alignment.center,
                                      child: const Text(
                                        'Photo',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.black,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 7),
                                Text(
                                  data['region']!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  data['desc']!,
                                  style: const TextStyle(fontSize: 13, color: Colors.black, height: 1.3),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          child: Text(
                            data['price']!,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
