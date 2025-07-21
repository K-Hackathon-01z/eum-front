import 'package:flutter/material.dart';

import 'home.dart';

// 예시 데이터 (DB에서 받아온다고 가정)
final question = "전통 기술을 배우고 싶은 이유는 무엇인가요?";
final options = ["취미", "취업", "창업", "멘토 만남", "기타"];

// 이건 그냥 고정해두어도 됨 db쓸 필요 없음
final description = "목표에 맞는 맞춤 추천을 제공해요!";

// 동적 위젯
class CareerTestScreen extends StatefulWidget {
  @override
  State<CareerTestScreen> createState() => _CareerTestScreenState();
}

class _CareerTestScreenState extends State<CareerTestScreen> {
  int selectedIndex = 0; // 선택된 인덱스

  // 여기다가 상태 관리 하는 서비스 두어야 함

  @override
  Widget build(BuildContext context) {
    // build 함수는 화면을 구성하는 메서드
    // 위젯 그려주는 함수
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        //leading: Icon(Icons.arrow_back, color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 홈화면으로 이동
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomeScreen()),
              (route) => false, // 이전 스택 전부 제거(설문 초기화 하려고)
              // 로그인 상태는 우리가 전역적으로 관리할거라 화면 날리는건 상관없음
            );
          },
        ),
        title: Text(
          "성향 검사",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          children: [
            SizedBox(height: 16),
            // 진행률
            Align(
              alignment: Alignment.center,
              child: Text(
                "20% 진행중...",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 24),
            // 질문
            Text(
              question,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            // 설명
            Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
            SizedBox(height: 32),
            // 선택지
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2열
                mainAxisSpacing: 16, // 열 사이 간격
                crossAxisSpacing: 16, // 행 사이 간격
                childAspectRatio: 2.3, // 가로, 세로 비율
                children: List.generate(options.length, (index) {
                  final isSelected = selectedIndex == index;
                  // 선택한 인덱스
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Color(0xFFB9A6E7)
                            : Color(0xFFF2EDFB),
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected
                            ? Border.all(color: Color(0xFF3B2D5B), width: 3)
                            : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        options[index],
                        style: TextStyle(
                          fontSize: 18,
                          color: isSelected
                              ? Color(0xFF3B2D5B)
                              : Color(0xFFB9A6E7),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
            // 다음으로 버튼
            Padding(
              padding: const EdgeInsets.only(bottom: 32.0, top: 8),
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    // 다음 질문으로 이동
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF2F2F2),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "다음으로",
                    style: TextStyle(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
