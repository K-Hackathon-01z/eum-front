import 'package:flutter/material.dart';

// 예시 데이터 (DB에서 받아온다고 가정)
final question = "전통 기술을 배우고 싶은 이유는 무엇인가요?";
final options = ["취미", "취업", "창업", "멘토 만남", "기타"];
// 이건 그냥 고정해두어도 됨 db쓸 필요 없음
final description = "목표에 맞는 맞춤 추천을 제공해요!";

// 동적 위젯
class CareerTestScreen extends StatefulWidget {
  const CareerTestScreen({super.key});

  @override
  State<CareerTestScreen> createState() => _CareerTestScreenState();
}

class _CareerTestScreenState extends State<CareerTestScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    // final controller = Provider.of<TestController>(context); // 상태 불러오기
    // final question = controller.currentQuestion;
    // final options = question.options;
    // var selectedIndex = controller.selectedIndex;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        //leading: Icon(Icons.arrow_back, color: Colors.black),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // 홈화면으로 이동 (네임드 라우트, 스택 초기화) 일단 이거 원래는 홈이 아닐텐데 임시로
            Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
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
              child: Text("20% 진행중...", style: TextStyle(fontWeight: FontWeight.bold)),
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
                        color: isSelected ? Color(0xFFB9A6E7) : Color(0xFFF2EDFB),
                        borderRadius: BorderRadius.circular(20),
                        border: isSelected ? Border.all(color: Color(0xFF3B2D5B), width: 3) : null,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        options[index],
                        style: TextStyle(
                          fontSize: 18,
                          color: isSelected ? Color(0xFF3B2D5B) : Color(0xFFB9A6E7),
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
                    // if (controller.isLast) {
                    //   controller.submit();
                    // } else {
                    //   controller.goToNext(); // 다음 문제로 이동
                    // }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF2F2F2),
                    elevation: 2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                  ),
                  child: Text(
                    "다음으로",
                    style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold, fontSize: 16),
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
