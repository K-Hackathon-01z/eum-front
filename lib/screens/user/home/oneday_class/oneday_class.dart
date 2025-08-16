import 'package:flutter/material.dart';
import '/widgets/user/oneday_class_card.dart';
import '../../../../widgets/user/sub_category.dart';
import 'card_detail.dart';

class OnedayClassScreen extends StatefulWidget {
  const OnedayClassScreen({super.key});

  @override
  State<OnedayClassScreen> createState() => _OnedayClassScreenState();
}

class _OnedayClassScreenState extends State<OnedayClassScreen> {
  final List<String> categories = ['인기', '공예', '섬유', '식문화', '예술', '기타'];
  int selectedCategory = 0;

  // 세부 카테고리 맵으로 관리 (확장성)
  final Map<String, List<String>> subCategoryMap = {
    '공예': ['금속', '나전 칠기', '도자기', '매듭장', '칠장', '한지'],
    '섬유': ['홍염장', '한복장', '자수', '매듭'],
    '식문화': ['전통주', '장', '다과'],
    '예술': ['판소리', '민요', '탈춤', '무용'],
    '기타': ['단청장', '소목장'],
  };
  int selectedSubCategory = 0;

  final Map<String, List<Map<String, String>>> classDataByCategory = {
    '인기': [
      {
        'title': '나전칠기의 기원',
        'region': '서울시 종로구',
        'desc': '나전칠기의 기원과 역사에 대한 강의입니다.',
        'price': '15,000원',
        'image': 'assets/images/oneday_class/hot01.png',
      },
      {
        'title': '전통 무용이란',
        'region': '서울시 동대문구',
        'desc': '전통 무용이 무엇인지 기원과 개념에 대해 학습합니다.',
        'price': '19,000원',
        'image': 'assets/images/oneday_class/hot02.png',
      },
      {
        'title': '한국 장 담그기 종류',
        'region': '서울시 송파구',
        'desc': '장의 종류와 그들의 특징에 대해 알아봅니다.',
        'price': '13,000원',
        'image': 'assets/images/oneday_class/hot03.png',
      },
      {
        'title': '금속 공예 체험 준비',
        'region': '서울시 광진구',
        'desc': '금속 공예를 체험하기 전 준비 과정입니다.',
        'price': '30,000원',
        'image': 'assets/images/oneday_class/hot04.png',
      },
    ],
    '공예': [
      {'title': '나전칠기 공예', 'region': '서울시 강남구', 'desc': '공예 클래스 1 - 나전칠기', 'price': '60,000원'},
      {'title': '도자기 만들기', 'region': '서울시 마포구', 'desc': '공예 클래스 2 - 도자기 만들기', 'price': '55,000원'},
      {'title': '한지 등 만들기', 'region': '서울시 종로구', 'desc': '공예 클래스 3 - 한지 등 만들기', 'price': '45,000원'},
      {'title': '목공예 체험', 'region': '서울시 성동구', 'desc': '공예 클래스 4 - 목공예 체험', 'price': '80,000원'},
    ],
    '섬유': [
      {'title': '자수 기초', 'region': '서울시 강서구', 'desc': '섬유 클래스 1 - 자수 기초', 'price': '40,000원'},
      {'title': '한복 만들기', 'region': '서울시 은평구', 'desc': '섬유 클래스 2 - 한복 만들기', 'price': '120,000원'},
      {'title': '매듭 공예', 'region': '서울시 구로구', 'desc': '섬유 클래스 3 - 매듭 공예', 'price': '35,000원'},
      {'title': '홍염장 체험', 'region': '서울시 동작구', 'desc': '섬유 클래스 4 - 홍염장 체험', 'price': '50,000원'},
    ],
    '식문화': [
      {
        'title': '삼해주 만들기 1',
        'region': '서울시 용산구',
        'desc': '삼해주의 기초 제작 과정입니다.',
        'price': '40,000원',
        'image': 'assets/images/oneday_class/drink/drink01.png',
      },
      {
        'title': '한국 전통주의 발효 과정',
        'region': '서울시 서대문구',
        'desc': '한국 전통주의 발효 과정을 배웁니다.',
        'price': '16,000원',
        'image': 'assets/images/oneday_class/drink/drink02.png',
      },
      {
        'title': '송절주 만들기 1',
        'region': '서울시 노원구',
        'desc': '송절주의 기초 제작 과정입니다.',
        'price': '38,000원',
        'image': 'assets/images/oneday_class/drink/drink03.png',
      },
    ],
    '예술': [
      {'title': '판소리 입문', 'region': '서울시 강북구', 'desc': '예술 클래스 1 - 판소리 입문', 'price': '90,000원'},
      {'title': '민요 배우기', 'region': '서울시 관악구', 'desc': '예술 클래스 2 - 민요 배우기', 'price': '55,000원'},
      {'title': '탈춤 체험', 'region': '서울시 금천구', 'desc': '예술 클래스 3 - 탈춤 체험', 'price': '60,000원'},
      {'title': '무용 워크숍', 'region': '서울시 도봉구', 'desc': '예술 클래스 4 - 무용 워크숍', 'price': '110,000원'},
    ],
    '기타': [
      {'title': '단청장 체험', 'region': '서울시 중랑구', 'desc': '기타 클래스 1 - 단청장 체험', 'price': '75,000원'},
      {'title': '소목장 입문', 'region': '서울시 양천구', 'desc': '기타 클래스 2 - 소목장 입문', 'price': '85,000원'},
      {'title': '전통 공예', 'region': '서울시 강동구', 'desc': '기타 클래스 3 - 전통 공예', 'price': '60,000원'},
      {'title': '창작 체험', 'region': '서울시 서대문구', 'desc': '기타 클래스 4 - 창작 체험', 'price': '50,000원'},
    ],
  };

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double horizontalPadding = 32; // 좌우 16씩
    final int categoryCount = categories.length;
    final double minTextWidth = 32; // 카테고리 텍스트의 최소 너비(더 넓은 간격)
    final double separatorWidth =
        (screenWidth - horizontalPadding - (categoryCount * minTextWidth)) / (categoryCount - 1);
    final classData = classDataByCategory[categories[selectedCategory]] ?? [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
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
                  onTap: () => setState(() {
                    selectedCategory = idx;
                    selectedSubCategory = 0;
                  }),
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
          // 공예/섬유 등 세부 카테고리 노출
          if (subCategoryMap.containsKey(categories[selectedCategory]))
            SubCategoryTab(
              subCategories: subCategoryMap[categories[selectedCategory]]!,
              selectedIndex: selectedSubCategory,
              onSelected: (idx) => setState(() => selectedSubCategory = idx),
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
                  childAspectRatio: 0.55,
                ),
                itemBuilder: (context, idx) {
                  final data = classData[idx];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => CardDetailScreen(
                            imageUrl: data['image'] ?? null,
                            desc: data['desc']!,
                            price: data['price']!,
                            region: data['region']!,
                            capacity: 3, // 필요시 데이터 추가
                            interest: 2, // 필요시 데이터 추가
                          ),
                        ),
                      );
                    },
                    child: OnedayClassCard(
                      title: data['title']!,
                      region: data['region']!,
                      desc: data['desc']!,
                      price: data['price']!,
                      imagePath: data['image'],
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
