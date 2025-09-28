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
                      width: 150,
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

                const Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Button(
                            text: '로그인',
                            width: 150,
                            height: 48,
                            backgroundColor: Colors.white,
                            textColor: Color(0xFF9785BA),
                            borderColor: Color(0xFF9785BA),
                            onPressed: () {
                              Navigator.pushReplacementNamed(context, '/login-email');
                            },
                          ),
                          SizedBox(width: 16),
                          Button(
                            text: '계정 생성하기',
                            width: 150,
                            height: 48,
                            backgroundColor: Colors.white,
                            textColor: Color(0xFF9785BA),
                            borderColor: Color(0xFF9785BA),
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup-name');
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Button(
                        text: '뒤로 가기',
                        width: 320,
                        height: 44,
                        backgroundColor: Color(0xFF9785BA),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                        },
                      ),
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
