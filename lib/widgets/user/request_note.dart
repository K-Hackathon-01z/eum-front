import 'package:flutter/material.dart';
import 'button.dart';
import 'popup.dart';

class RequestNote extends StatelessWidget {
  final String nickname;
  final ValueChanged<String>? onSend;

  const RequestNote({super.key, this.nickname = 'JunHoKim', this.onSend});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final size = MediaQuery.of(context).size;
    final double cardWidth = size.width * 0.92;
    final double cardHeight = size.height * 0.85;
    return Center(
      child: Container(
        width: cardWidth,
        height: cardHeight,
        decoration: BoxDecoration(
          color: const Color(0xFFE3E3E3),
          borderRadius: BorderRadius.circular(cardWidth * 0.085),
        ),
        child: Stack(
          children: [
            // 메세지 전송 버튼
            Positioned(
              left: cardWidth * 0.16,
              top: cardHeight * 0.86,
              child: Button(
                text: '메세지 전송',
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => CommonPopup(
                      showCloseIcon: false,
                      icon: Icons.send,
                      iconColor: const Color(0XFF9785BA),
                      title: "매칭 신청할까요?",
                      message: "매칭 신청 후에는 삭제가 불가능합니다.",
                      button1Text: "전송",
                      onButtonFirstPressed: () {
                        if (onSend != null) onSend!(controller.text);
                        Navigator.of(context).pop(); // 첫 번째 팝업 닫기
                        Navigator.of(context).pop(); // RequestNote 닫기
                        // 매칭 신청 완료 팝업 띄우기
                        showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) => CommonPopup(
                            showCloseIcon: true,
                            icon: Icons.check_circle_outline,
                            iconColor: const Color(0xFF9785BA),
                            title: "매칭 신청 완료!",
                            message: "매칭 신청이 성공적으로 완료되었습니다.",
                            button1Text: "홈 바로가기",
                            onButtonFirstPressed: () {
                              Navigator.of(context).pop(); // 완료 팝업 닫기
                              Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                            },
                            button2Text: "마이페이지 바로가기",
                            onButtonSecondPressed: () {
                              Navigator.of(context).pop(); // 완료 팝업 닫기
                              final navigator = Navigator.of(context);
                              navigator.pushNamedAndRemoveUntil('/home', (route) => false, arguments: {'tab': 3});
                            },
                          ),
                        );
                      },
                      button2Text: "취소",
                      onButtonSecondPressed: () {
                        Navigator.of(context).pop(); // 팝업 닫기
                      },
                    ),
                  );
                },
                width: cardWidth * 0.68,
                height: 48,
                backgroundColor: Colors.white,
                textColor: const Color(0xFF9785BA),
                borderColor: const Color(0xFF9785BA),
              ),
            ),
            // 상단 프로필 카드
            Positioned(
              left: cardWidth * 0.014,
              top: cardHeight * 0.10,
              child: Container(
                width: cardWidth * 0.97,
                height: cardHeight * 0.17,
                child: Stack(
                  children: [
                    Positioned(
                      left: cardWidth * 0.075,
                      top: cardHeight * 0.012,
                      child: Container(
                        width: cardWidth * 0.82,
                        height: cardHeight * 0.13,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(cardWidth * 0.085),
                        ),
                      ),
                    ),
                    Positioned(
                      left: cardWidth * 0.135,
                      top: cardHeight * 0.039,
                      child: Container(
                        width: cardWidth * 0.15,
                        height: cardWidth * 0.15,
                        decoration: BoxDecoration(color: const Color(0xFF747474), shape: BoxShape.circle),
                      ),
                    ),
                    Positioned(
                      left: cardWidth * 0.315,
                      top: cardHeight * 0.045,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: cardWidth * 0.41,
                            child: Text(
                              nickname,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.w700,
                                height: 1.10,
                              ),
                            ),
                          ),
                          SizedBox(height: cardHeight * 0.018),
                          SizedBox(width: cardWidth * 0.50, child: _RequestNoteCheckRow()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // 메세지 입력 영역
            Positioned(
              left: cardWidth * 0.09,
              top: cardHeight * 0.28,
              child: Container(
                width: cardWidth * 0.82,
                height: cardHeight * 0.55,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(cardWidth * 0.085)),
                child: Padding(
                  padding: EdgeInsets.all(cardWidth * 0.05),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: cardHeight * 0.02),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              '장인•작가님께 전달하고 싶은 메시지를\n입력해주세요. (300자 이내)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 2.20,
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: cardHeight * 0.03),
                      Expanded(
                        child: SingleChildScrollView(
                          child: TextField(
                            controller: controller,
                            maxLength: 300,
                            maxLines: 10,
                            decoration: InputDecoration(
                              hintText: '메시지를 입력하세요',
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(cardWidth * 0.045)),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: cardWidth * 0.03,
                                vertical: cardHeight * 0.01,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // 닫기(X) 아이콘
            Positioned(
              right: 10,
              top: 10,
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: SizedBox(
                  width: cardWidth * 0.09,
                  height: cardWidth * 0.09,
                  child: const Icon(Icons.close, size: 30, color: Colors.black),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RequestNoteCheckRow extends StatefulWidget {
  const _RequestNoteCheckRow({Key? key}) : super(key: key);
  @override
  State<_RequestNoteCheckRow> createState() => _RequestNoteCheckRowState();
}

class _RequestNoteCheckRowState extends State<_RequestNoteCheckRow> {
  bool checked = false;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 18,
          height: 18,
          child: Checkbox(
            value: checked,
            onChanged: (val) {
              setState(() {
                checked = val ?? false;
              });
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity(horizontal: -4, vertical: -4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        SizedBox(width: 5),
        Text(
          '장인•작가님께 내 정보 함께 보내기',
          style: const TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.w700, height: 2.20),
        ),
      ],
    );
  }
}
