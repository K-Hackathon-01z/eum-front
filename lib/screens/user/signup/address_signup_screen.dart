import '../../../widgets/user/signup_step_indicator.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../widgets/user/button.dart';
import '../../../widgets/user/popup.dart';

class AddressSignupScreen extends StatefulWidget {
  const AddressSignupScreen({super.key});

  @override
  State<AddressSignupScreen> createState() => _AddressSignupScreenState();
}

class _AddressSignupScreenState extends State<AddressSignupScreen> {
  Future<List<String>> searchAddress(String query) async {
    final apiKey = '211654418f620b18c194cda089622673';
    final url = Uri.parse('https://dapi.kakao.com/v2/local/search/address.json?query=$query');
    final response = await http.get(url, headers: {'Authorization': 'KakaoAK $apiKey'});
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List docs = data['documents'];
      return docs.map<String>((e) => e['address_name'] as String).toList();
    } else {
      return [];
    }
  }

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
              const SizedBox(height: 12),
              Button(
                text: '검색',
                width: double.infinity,
                height: 44,
                backgroundColor: const Color(0xFF9785BA),
                textColor: Colors.white,
                onPressed: () async {
                  final keyword = _addressController.text.trim();
                  if (keyword.isEmpty) {
                    showDialog(
                      context: context,
                      builder: (_) => CommonPopup(
                        icon: Icons.warning_amber_rounded,
                        title: '입력 오류',
                        message: '주소 검색어를 입력해주세요.',
                        button1Text: '확인',
                        onButtonFirstPressed: () => Navigator.of(context).pop(),
                      ),
                    );
                    return;
                  }
                  List<String> results = await searchAddress(keyword);
                  await showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text('주소 선택'),
                        content: SizedBox(
                          width: 300,
                          child: results.isEmpty
                              ? const Text('검색 결과가 없습니다.')
                              : SizedBox(
                                  height: 200,
                                  child: ListView.builder(
                                    itemCount: results.length,
                                    itemBuilder: (context, idx) {
                                      return ListTile(
                                        title: Text(results[idx]),
                                        onTap: () {
                                          _addressController.text = results[idx];
                                          Navigator.of(context).pop();
                                        },
                                      );
                                    },
                                  ),
                                ),
                        ),
                        actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: const Text('취소'))],
                      );
                    },
                  );
                },
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
