import '../../../widgets/user/signup_step_indicator.dart';
import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';
import '../../../widgets/user/popup.dart';

class AddressSignupScreen extends StatefulWidget {
  const AddressSignupScreen({super.key});

  @override
  State<AddressSignupScreen> createState() => _AddressSignupScreenState();
}

class _AddressSignupScreenState extends State<AddressSignupScreen> {
  final TextEditingController _addressController = TextEditingController();

  @override
  void dispose() {
    _addressController.dispose();
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
              SignupStepIndicator(currentStep: 4, totalSteps: 5, stepLabels: ['닉네임', '이메일', '생년월일', '성별', '주소']),
              const Spacer(flex: 1),
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  '주소를 입력해주세요',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff3B2D5B)),
                  textAlign: TextAlign.center,
                ),
              ),
              TextField(
                controller: _addressController,
                decoration: const InputDecoration(labelText: '주소', border: OutlineInputBorder()),
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 18),
                maxLength: 50,
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
                        final address = _addressController.text.trim();
                        if (address.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (_) => CommonPopup(
                              icon: Icons.warning_amber_rounded,
                              title: '입력 오류',
                              message: '주소를 입력해주세요.',
                              button1Text: '확인',
                              onButtonFirstPressed: () => Navigator.of(context).pop(),
                            ),
                          );
                          return;
                        }
                        // TODO: 주소 저장 로직 추가 가능
                        Navigator.pushNamed(context, '/signup-success');
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
