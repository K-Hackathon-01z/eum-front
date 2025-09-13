import 'package:flutter/material.dart';
import 'package:eum_demo/widgets/user/button.dart';

class ArtistIntroScreen extends StatelessWidget {
  const ArtistIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Column(
                  children: const [
                    Text(
                      '장인·작가 모드',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                        height: 1.3,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      '작품과 기술을 쉽게 소개하고\n수업을 등록해 보세요.\n복잡한 절차 없이 시작할 수 있어요.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF4B5563),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Semantics(
                  label: '장인 모드 시작하기',
                  button: true,
                  child: Button(
                    text: '장인 모드 시작하기',
                    width: double.infinity,
                    height: 56,
                    backgroundColor: const Color(0xFF6D5BD0),
                    textColor: Colors.white,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/artist-home');
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Semantics(
                  label: '뒤로 가기',
                  button: true,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text(
                      '뒤로 가기',
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xFF6B7280),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
