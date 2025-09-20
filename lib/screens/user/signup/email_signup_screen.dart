import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';

class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final TextEditingController _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            children: [
              const Spacer(flex: 2),
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  '이메일 주소를 입력해주세요',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff3B2D5B)),
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: '이메일', border: OutlineInputBorder()),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.emailAddress,
              ),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Button(
                      text: '다음으로',
                      width: double.infinity,
                      height: 48,
                      textColor: Colors.white,
                      backgroundColor: const Color(0xFF9785BA),
                      onPressed: () {
                        // 다음 회원가입 단계로 이동 (추후 구현)
                      },
                    ),
                    const SizedBox(height: 16),
                    Button(
                      text: '돌아가기',
                      width: double.infinity,
                      height: 48,
                      backgroundColor: Colors.white,
                      textColor: const Color(0xFF9785BA),
                      borderColor: const Color(0xFF9785BA),
                      onPressed: () {
                        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
