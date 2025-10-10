import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/creator_provider.dart';
import '../../providers/send_note_provider.dart';
import '../../models/note/send_note.dart';
import '../../providers/sent_note_provider.dart';
import 'button.dart';
import 'popup.dart';

// RequestNote를 showModalBottomSheet로 띄우는 함수
Future<void> showRequestNoteBottomSheet({
  required BuildContext context,
  required String nickname,
  required String artisanEmail,
  required int userId,
}) async {
  await showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom, left: 8, right: 8, top: 32),
      child: Material(
        color: Colors.transparent,
        child: RequestNote(nickname: nickname, artisanEmail: artisanEmail, userId: userId),
      ),
    ),
  );
}

class RequestNote extends StatefulWidget {
  final String nickname;
  final String artisanEmail;
  final int userId;

  const RequestNote({super.key, this.nickname = '닉네임', required this.artisanEmail, required this.userId});

  @override
  State<RequestNote> createState() => _RequestNoteState();
}

class _RequestNoteState extends State<RequestNote> {
  final TextEditingController controller = TextEditingController();
  bool isAnonymous = false; // 체크박스 상태에 따라 변경됨

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double cardWidth = size.width * 0.92;
    final double cardHeight = size.height * 0.85;

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus(); // 바깥 클릭 시 키보드 내림
      },
      child: SingleChildScrollView(
        child: Center(
          child: Container(
            width: cardWidth,
            constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.85),
            decoration: BoxDecoration(
              color: const Color(0xFFE3E3E3),
              borderRadius: BorderRadius.circular(cardWidth * 0.085),
            ),
            child: Stack(
              children: [
                // 메세지 전송 버튼
                Positioned(
                  left: cardWidth * 0.16,
                  top: cardHeight * 0.88,
                  child: Button(
                    text: '메세지 전송',
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (context) => CommonPopup(
                          showCloseIcon: false,
                          icon: Icons.send,
                          iconColor: const Color(0XFF9785BA),
                          title: "매칭 신청할까요?",
                          message: "매칭 신청 후에는 삭제가 불가능합니다.",
                          button1Text: "전송",
                          onButtonFirstPressed: () async {
                            final creatorProvider = Provider.of<CreatorProvider>(context, listen: false);
                            final sendNoteProvider = Provider.of<SendNoteProvider>(context, listen: false);

                            await creatorProvider.fetchCreatorByEmail(widget.artisanEmail);
                            final creator = creatorProvider.creatorByEmail;

                            if (creator == null) {
                              showDialog(
                                context: context,
                                builder: (context) => CommonPopup(
                                  showCloseIcon: true,
                                  icon: Icons.error,
                                  iconColor: const Color(0xFF9785BA),
                                  title: "장인 정보 조회 실패",
                                  message: "장인 정보를 찾을 수 없습니다.",
                                  button1Text: "닫기",
                                  onButtonFirstPressed: () => Navigator.of(context).pop(),
                                ),
                              );
                              return;
                            }

                            final noteRequest = SendNote(
                              userId: widget.userId,
                              artisanId: creator.id,
                              message: controller.text,
                              isAnonymous: isAnonymous,
                            );

                            await sendNoteProvider.sendNote(noteRequest);

                            if (sendNoteProvider.success) {
                              // 매칭 신청 내역 즉시 갱신
                              final sentNoteProvider = Provider.of<SentNoteProvider>(context, listen: false);
                              await sentNoteProvider.fetchSentNotes(widget.userId);

                              showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => CommonPopup(
                                  showCloseIcon: false,
                                  icon: Icons.check_circle_outline,
                                  iconColor: const Color(0xFF9785BA),
                                  title: "매칭 신청 완료!",
                                  message: "매칭 신청이 성공적으로 완료되었습니다.",
                                  button1Text: "홈 바로가기",
                                  onButtonFirstPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pushNamedAndRemoveUntil('/home', (route) => false);
                                  },
                                  button2Text: "마이페이지 바로가기",
                                  onButtonSecondPressed: () {
                                    Navigator.of(context).pop();
                                    Navigator.of(context).pop();
                                    final navigator = Navigator.of(context);
                                    navigator.pushNamedAndRemoveUntil('/home', (route) => false, arguments: {'tab': 3});
                                  },
                                ),
                              );
                            } else {
                              showDialog(
                                context: context,
                                builder: (context) => CommonPopup(
                                  showCloseIcon: true,
                                  icon: Icons.error,
                                  iconColor: const Color(0xFF9785BA),
                                  title: "전송 실패",
                                  message: sendNoteProvider.error ?? "쪽지 전송에 실패했습니다.",
                                  button1Text: "닫기",
                                  onButtonFirstPressed: () => Navigator.of(context).pop(),
                                ),
                              );
                            }
                          },
                          button2Text: "취소",
                          onButtonSecondPressed: () => Navigator.of(context).pop(),
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
                            decoration: const BoxDecoration(color: Color(0xFF747474), shape: BoxShape.circle),
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
                                  widget.nickname,
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
                              SizedBox(
                                width: cardWidth * 0.50,
                                child: _RequestNoteCheckRow(
                                  onCheckedChanged: (value) {
                                    setState(() {
                                      isAnonymous = !value;
                                    });
                                  },
                                ),
                              ),
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
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(cardWidth * 0.085),
                    ),
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
                                  '장인•작가님께 전달하고 싶은 메시지를\n입력해주세요. (200자 이내)',
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
                                maxLength: 200,
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
        ),
      ),
    );
  }
}

class _RequestNoteCheckRow extends StatefulWidget {
  final ValueChanged<bool>? onCheckedChanged; // 부모로 전달할 콜백

  const _RequestNoteCheckRow({Key? key, this.onCheckedChanged}) : super(key: key);

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
              widget.onCheckedChanged?.call(checked); // 상태 부모로 전달
            },
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
        ),
        const SizedBox(width: 5),
        const Text(
          '장인•작가님께 내 정보 함께 보내기',
          style: TextStyle(color: Colors.black54, fontSize: 10, fontWeight: FontWeight.w700, height: 2.20),
        ),
      ],
    );
  }
}
