import '../../../widgets/user/signup_step_indicator.dart';
import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';
import '../../../utils/validators.dart';
import '../../../widgets/user/popup.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';

class EmailSignupScreen extends StatefulWidget {
  const EmailSignupScreen({super.key});

  @override
  State<EmailSignupScreen> createState() => _EmailSignupScreenState();
}

class _EmailSignupScreenState extends State<EmailSignupScreen> {
  bool _isCodeSent = false;
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
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 32),
                SignupStepIndicator(currentStep: 1, totalSteps: 5, stepLabels: ['이름', '이메일', '나이', '성별', '주소']),
                const SizedBox(height: 16),
                const Padding(
                  padding: EdgeInsets.only(bottom: 24),
                  child: Text(
                    '이메일 주소와 코드를 입력해주세요',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xff3B2D5B)),
                    textAlign: TextAlign.center,
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(labelText: '이메일', border: OutlineInputBorder()),
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 18),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 150,
                          height: 40,
                          child: Button(
                            text: _isCodeSent ? '인증코드 재전송' : '인증코드 전송',
                            width: 140,
                            height: 40,
                            textColor: Colors.white,
                            backgroundColor: const Color(0xFF9785BA),
                            onPressed: () async {
                              final emailError = Validators.validateEmail(_emailController.text);
                              if (emailError != null) {
                                showDialog(
                                  context: context,
                                  builder: (_) => CommonPopup(
                                    icon: Icons.warning_amber_rounded,
                                    title: '입력 오류',
                                    message: emailError,
                                    button1Text: '확인',
                                    onButtonFirstPressed: () => Navigator.of(context).pop(),
                                  ),
                                );
                                return;
                              }
                              // 이메일 중복 체크
                              final userProvider = Provider.of<UserProvider>(context, listen: false);
                              await userProvider.fetchAllUsers();
                              final isDuplicate = userProvider.users.any(
                                (user) => user['email'] == _emailController.text,
                              );
                              if (isDuplicate) {
                                showDialog(
                                  context: context,
                                  builder: (_) => CommonPopup(
                                    icon: Icons.warning_amber_rounded,
                                    title: '중복 이메일',
                                    message: '이미 가입된 이메일입니다.',
                                    button1Text: '확인',
                                    onButtonFirstPressed: () => Navigator.of(context).pop(),
                                  ),
                                );
                                return;
                              }
                              // 인증코드 발송 API 연동
                              final authProvider = Provider.of<AuthProvider>(context, listen: false);
                              await authProvider.requestEmailCode(_emailController.text);
                              if (authProvider.error != null) {
                                showDialog(
                                  context: context,
                                  builder: (_) => CommonPopup(
                                    icon: Icons.warning_amber_rounded,
                                    title: '오류',
                                    message: authProvider.error!,
                                    button1Text: '확인',
                                    onButtonFirstPressed: () => Navigator.of(context).pop(),
                                  ),
                                );
                                return;
                              }
                              setState(() {
                                _isCodeSent = true;
                              });
                              showDialog(
                                context: context,
                                builder: (_) => CommonPopup(
                                  icon: Icons.check_circle_outline,
                                  title: '인증코드 발송',
                                  message: '이메일로 인증코드를 전송했습니다.',
                                  button1Text: '확인',
                                  onButtonFirstPressed: () => Navigator.of(context).pop(),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
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
                const SizedBox(height: 32),
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
                        onPressed: () async {
                          final emailError = Validators.validateEmail(_emailController.text);
                          final codeError = Validators.validateAuthCode(_codeController.text);
                          if (emailError != null) {
                            showDialog(
                              context: context,
                              builder: (_) => CommonPopup(
                                icon: Icons.warning_amber_rounded,
                                title: '입력 오류',
                                message: emailError,
                                button1Text: '확인',
                                onButtonFirstPressed: () => Navigator.of(context).pop(),
                              ),
                            );
                            return;
                          }
                          if (codeError != null) {
                            showDialog(
                              context: context,
                              builder: (_) => CommonPopup(
                                icon: Icons.warning_amber_rounded,
                                title: '입력 오류',
                                message: codeError,
                                button1Text: '확인',
                                onButtonFirstPressed: () => Navigator.of(context).pop(),
                              ),
                            );
                            return;
                          }
                          // 인증코드 확인 API 연동
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          await authProvider.confirmEmailCode(_emailController.text, _codeController.text);
                          if (authProvider.error != null) {
                            showDialog(
                              context: context,
                              builder: (_) => CommonPopup(
                                icon: Icons.warning_amber_rounded,
                                title: '오류',
                                message: authProvider.error!,
                                button1Text: '확인',
                                onButtonFirstPressed: () => Navigator.of(context).pop(),
                              ),
                            );
                            return;
                          }
                          // 이메일을 AuthProvider에 저장
                          authProvider.setEmail(_emailController.text);
                          Navigator.pushNamed(context, '/signup-age');
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
                          Navigator.pushNamed(context, '/signup-name');
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
