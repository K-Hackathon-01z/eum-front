import '../../../widgets/user/signup_step_indicator.dart';
import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';
import '../../../utils/validators.dart';
import '../../../widgets/user/popup.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class AgeSignupScreen extends StatefulWidget {
  const AgeSignupScreen({super.key});

  @override
  State<AgeSignupScreen> createState() => _AgeSignupScreenState();
}

class _AgeSignupScreenState extends State<AgeSignupScreen> {
  final TextEditingController _ageController = TextEditingController();

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                SignupStepIndicator(currentStep: 2, totalSteps: 5, stepLabels: ['닉네임', '이메일', '나이', '성별', '주소']),
                const SizedBox(height: 24),
                const Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Text(
                    '나이를 입력해주세요 (만 나이 기준)',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff3B2D5B)),
                    textAlign: TextAlign.center,
                  ),
                ),
                TextField(
                  controller: _ageController,
                  decoration: const InputDecoration(labelText: '나이', border: OutlineInputBorder()),
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                  keyboardType: TextInputType.number,
                  maxLength: 3,
                ),
                const SizedBox(height: 40),
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
                          final ageError = Validators.validateAge(_ageController.text);
                          if (ageError != null) {
                            showDialog(
                              context: context,
                              builder: (_) => CommonPopup(
                                icon: Icons.warning_amber_rounded,
                                title: '입력 오류',
                                message: ageError,
                                button1Text: '확인',
                                onButtonFirstPressed: () => Navigator.of(context).pop(),
                              ),
                            );
                            return;
                          }
                          Provider.of<AuthProvider>(context, listen: false).setAge(int.parse(_ageController.text));
                          Navigator.pushNamed(context, '/signup-gender');
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
