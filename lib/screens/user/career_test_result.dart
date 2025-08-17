// recommendation_result_screen.dart
import 'package:flutter/material.dart';

class CareerTestResultScreen extends StatelessWidget {
  final List<String> recommendations; // 서버로부터 받은 추천 기술 리스트 (타입은 실제 데이터에 맞게 수정)

  const CareerTestResultScreen({Key? key, required this.recommendations})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('추천 기술 스택')),
      body: ListView.builder(
        itemCount: recommendations.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(recommendations[index]),
            // 여기에 각 기술에 대한 추가 정보를 표시하거나 디자인을 적용할 수 있습니다.
          );
        },
      ),
    );
  }
}
