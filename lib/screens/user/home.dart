import 'package:flutter/material.dart';
import '../../widgets/user/navigation.dart';
import 'career.dart';
import 'map.dart';
import 'my_info.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(), // 0: 홈
    MapScreen(), // 1: 지도
    CareerScreen(), // 2: 커리어
    MyInfoScreen(), // 3: 내 정보
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      body: SafeArea(
        child: IndexedStack(index: _currentIndex, children: _pages),
      ),
      bottomNavigationBar: CustomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

class PopularClassCard extends StatelessWidget {
  const PopularClassCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      margin: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 80,
            width: double.infinity,
            decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(30)),
            child: const Center(
              child: Text('Photo', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
            ),
          ),
          const SizedBox(height: 4),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text('원데이 클래스 상세 설명입니다.', style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold)),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            //child: Text('52,000원', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class BannerButton extends StatelessWidget {
  final IconData icon;
  final String text;
  const BannerButton({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
      ),
      child: Row(
        children: [
          Icon(icon, size: 28, color: Colors.black54),
          const SizedBox(width: 16),
          Text(text, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          const Spacer(),
          const Icon(Icons.arrow_forward_ios, size: 18, color: Colors.black26),
        ],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // 헤더
        Container(
          height: 130,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Container(
              width: 98,
              height: 52,
              color: Colors.grey[300], // 이미지 자리
              child: const Center(child: Text('로고')),
            ),
          ),
        ),
        // 인기 강의 (오늘의 인기 강의)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
            width: double.infinity,
            height: 188,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('오늘의 인기 강의', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward, size: 28, color: Colors.grey[700]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 140,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return PopularClassCard();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // 인기 강의 (위치 기반 추천)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
            width: double.infinity,
            height: 188,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('사용자 위치 기반 추천 강의', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Icon(Icons.arrow_forward, size: 28, color: Colors.grey[700]),
                    ],
                  ),
                ),
                SizedBox(
                  height: 140,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    itemCount: 3,
                    separatorBuilder: (_, __) => const SizedBox(width: 8),
                    itemBuilder: (context, index) {
                      return PopularClassCard();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        // 정부지원금 배너
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Container(
            margin: const EdgeInsets.only(bottom: 8),
            width: double.infinity,
            height: 108,
            child: Row(
              children: [
                const SizedBox(width: 16),
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(color: Colors.grey[400], borderRadius: BorderRadius.circular(36)),
                  child: const Center(child: Text('임티')),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        '이음 제안',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.black54),
                      ),
                      const SizedBox(height: 4),
                      const Text('나에게 꼭 맞는 정부 지원 혜택', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.grey[700]?.withOpacity(0.5),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: const Text(
                              '클릭 한 번으로 확인하기',
                              style: TextStyle(fontSize: 9, color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.arrow_forward, size: 20, color: Colors.grey[700]),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ),
        // 목록들 배너
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0),
          child: Column(
            children: [
              BannerButton(icon: Icons.people, text: '장인 • 작가 목록 보기'),
              BannerButton(icon: Icons.list, text: '전통 기술 목록 보기'),
            ],
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
