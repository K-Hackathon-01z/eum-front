import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';

class TitleScreen extends StatelessWidget {
  const TitleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            // ← 이 부분 추가!
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                // 이미지 2개를 세로로 중앙에 배치
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 290,
                      height: 155,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(28),
                      //   border: Border.all(color: Color(0xFFE0E0E0)),
                      // ),
                      child: Center(child: Image.asset('assets/logos/eum_logo_title.png', fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      width: 140,
                      height: 100,
                      // decoration: BoxDecoration(
                      //   borderRadius: BorderRadius.circular(20),
                      //   border: Border.all(color: Color(0xFFE0E0E0)),
                      // ),
                      child: Center(child: Image.asset('assets/logos/eum_word_title.png', fit: BoxFit.contain)),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: Button(
                    text: '시작하기',
                    width: 350,
                    height: 48,
                    color: Color(0xffDAD3E8),
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // TODO: 이동 로직 구현
                        },
                        child: const Text(
                          '장인·작가이신가요?',
                          style: TextStyle(color: Color(0xFF868383), fontSize: 15, fontWeight: FontWeight.w500),
                        ),
                      ),
                      Container(width: 120, height: 2, color: Color(0xFF868383)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
