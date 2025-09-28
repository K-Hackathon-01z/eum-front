import 'package:flutter/material.dart';
import '../../../widgets/user/button.dart';
import '../../../utils/validators.dart';
import '../../../widgets/user/popup.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../services/user/my_info_service.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
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
              const SizedBox(height: 32),
              const Spacer(flex: 1),
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
              const SizedBox(height: 24),
              const Spacer(flex: 3),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Column(
                  children: [
                    Button(
                      text: '다음으로',
                      width: double.infinity,
                      height: 48,
                      backgroundColor: Colors.white,
                      textColor: const Color(0xFF9785BA),
                      borderColor: const Color(0xFF9785BA),
                      onPressed: () async {
                        final email = _emailController.text.trim();
                        if (email.isEmpty) {
                          showDialog(
                            context: context,
                            builder: (_) => CommonPopup(
                              icon: Icons.warning_amber_rounded,
                              title: '입력 오류',
                              message: '이메일을 입력해주세요.',
                              button1Text: '확인',
                              onButtonFirstPressed: () => Navigator.of(context).pop(),
                            ),
                          );
                          return;
                        }
                        final emailError = Validators.validateEmail(email);
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
                        final userData = await MyInfoService.getUserByEmail(email);
                        if (userData.isNotEmpty && userData['email'] == email) {
                          final authProvider = Provider.of<AuthProvider>(context, listen: false);
                          await authProvider.login(email);
                          if (authProvider.success) {
                            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                          }
                          return;
                        }
                        showDialog(
                          context: context,
                          builder: (_) => CommonPopup(
                            icon: Icons.warning_amber_rounded,
                            title: '로그인 실패',
                            message: '존재하지 않는 이메일입니다.',
                            button1Text: '확인',
                            onButtonFirstPressed: () => Navigator.of(context).pop(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    Button(
                      text: '돌아가기',
                      width: double.infinity,
                      height: 48,
                      backgroundColor: const Color(0xFF9785BA),
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
    );
  }
}
