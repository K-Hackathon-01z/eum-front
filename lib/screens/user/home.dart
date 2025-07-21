import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            width: double.infinity,
            height: 108,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0x4DF5B342), // 30% 불투명도
                        Color(0x4DF5E94C), // 30% 불투명도
                      ],
                      stops: [0.11, 0.96],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 4)],
                  ),
                ),
                Positioned(
                  left: 276,
                  top: 18,
                  child: Container(
                    width: 72,
                    height: 72,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: Center(child: SvgPicture.asset('assets/icons/money.svg')),
                  ),
                ),
                Positioned(
                  left: 35,
                  top: 12,
                  child: SizedBox(
                    width: 67,
                    height: 23,
                    child: Text(
                      '이음 제안',
                      style: TextStyle(
                        color: Colors.black.withValues(alpha: 0.50),
                        fontSize: 13,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.69,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 35,
                  top: 35,
                  child: SizedBox(
                    width: 261,
                    height: 30,
                    child: Text(
                      '나에게 꼭 맞는 정부 지원 혜택',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w700,
                        height: 1.29,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 35,
                  top: 69,
                  child: Container(
                    width: 256,
                    height: 28,
                    child: Stack(
                      children: [
                        Positioned(
                          left: 0,
                          top: 0,
                          child: Container(
                            width: 205,
                            height: 28,
                            decoration: ShapeDecoration(
                              color: const Color(0x7F4E4E4E),
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 48,
                          top: 3,
                          child: Text(
                            '클릭 한 번으로 확인하기',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 11,
                              fontFamily: 'Inter',
                              fontWeight: FontWeight.w700,
                              height: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
