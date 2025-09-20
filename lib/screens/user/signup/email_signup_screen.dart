import '../../../widgets/user/signup_step_indicator.dart';
import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';

class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _codeController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _codeController.dispose();
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
              const SizedBox(height: 32),
              SignupStepIndicator(currentStep: 1, totalSteps: 4, stepLabels: ['닉네임', '이메일', '생년월일', '성별']),
              const Spacer(flex: 1),
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  '이메일 주소와 코드를 입력해주세요',
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
              const SizedBox(height: 24),
              TextField(
                controller: _codeController,
                decoration: const InputDecoration(labelText: '인증코드', border: OutlineInputBorder()),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
                keyboardType: TextInputType.number,
                maxLength: 6,
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
                        Navigator.pushNamed(context, '/signup-birthday');
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
