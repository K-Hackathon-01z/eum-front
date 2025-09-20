import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';

class NicknameSignupScreen extends StatefulWidget {
  const NicknameSignupScreen({super.key});

  @override
  State<NicknameSignupScreen> createState() => _NicknameSignupScreenState();
}

class _NicknameSignupScreenState extends State<NicknameSignupScreen> {
  final TextEditingController _nicknameController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
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
                  '사용할 닉네임을 입력해주세요',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff3B2D5B)),
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                controller: _nicknameController,
                decoration: const InputDecoration(labelText: '닉네임', border: OutlineInputBorder()),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
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
