import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';

class MyInfoFakeScreen extends StatelessWidget {
  const MyInfoFakeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Spacer(flex: 2),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 290,
                      height: 155,
                      child: Center(child: Image.asset('assets/logos/eum_logo_title.png', fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      width: 140,
                      height: 100,
                      child: const Center(
                        child: Text(
                          '로그인이 필요한 서비스입니다',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xFF868383)),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(flex: 3),
                Padding(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Button(
                    text: '로그인하기',
                    width: 350,
                    height: 48,
                    textColor: Colors.white,
                    backgroundColor: Color(0xFF9785BA),
                    onPressed: () {},
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/signup-nickname');
                        },
                        child: const Text(
                          '계정이 없으신가요?',
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
