import '../../../widgets/user/signup_step_indicator.dart';
import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';
import '../../../utils/validators.dart';
import '../../../widgets/user/popup.dart';

class GenderSignupScreen extends StatefulWidget {
  const GenderSignupScreen({super.key});

  @override
  State<GenderSignupScreen> createState() => _GenderSignupScreenState();
}

class _GenderSignupScreenState extends State<GenderSignupScreen> {
  String? _selectedGender;

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
              SignupStepIndicator(currentStep: 3, totalSteps: 4, stepLabels: ['닉네임', '이메일', '생년월일', '성별']),
              const Spacer(flex: 1),
              const Padding(
                padding: EdgeInsets.only(bottom: 24),
                child: Text(
                  '성별을 선택해주세요',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff3B2D5B)),
                  textAlign: TextAlign.center,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ChoiceChip(
                    showCheckmark: false,
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.male, size: 64, color: _selectedGender == 'male' ? Colors.white : Color(0xFF9785BA)),
                        const SizedBox(height: 12),
                        Text('남성', style: TextStyle(fontSize: 22)),
                      ],
                    ),
                    selected: _selectedGender == 'male',
                    onSelected: (selected) {
                      setState(() {
                        _selectedGender = 'male';
                      });
                    },
                    selectedColor: const Color(0xFF9785BA),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(color: _selectedGender == 'male' ? Colors.white : const Color(0xFF9785BA)),
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  ),
                  const SizedBox(height: 32, width: 20),
                  ChoiceChip(
                    showCheckmark: false,
                    label: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.female,
                          size: 64,
                          color: _selectedGender == 'female' ? Colors.white : Color(0xFF9785BA),
                        ),
                        const SizedBox(height: 12),
                        Text('여성', style: TextStyle(fontSize: 22)),
                      ],
                    ),
                    selected: _selectedGender == 'female',
                    onSelected: (selected) {
                      setState(() {
                        _selectedGender = 'female';
                      });
                    },
                    selectedColor: const Color(0xFF9785BA),
                    backgroundColor: Colors.white,
                    labelStyle: TextStyle(color: _selectedGender == 'female' ? Colors.white : const Color(0xFF9785BA)),
                    padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 32),
                  ),
                ],
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
                        final genderError = Validators.validateGender(_selectedGender);
                        if (genderError != null) {
                          showDialog(
                            context: context,
                            builder: (_) => CommonPopup(
                              icon: Icons.warning_amber_rounded,
                              title: '입력 오류',
                              message: genderError,
                              button1Text: '확인',
                              onButtonFirstPressed: () => Navigator.of(context).pop(),
                            ),
                          );
                          return;
                        }
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
