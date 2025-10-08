import 'button.dart';
import 'request_note.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';

class CreatorDetail extends StatelessWidget {
  final String name;
  final String skill;
  final String works;
  final String bio;
  final String email;
  final Widget? image;
  final VoidCallback? onMatch;

  const CreatorDetail({
    super.key,
    required this.name,
    required this.skill,
    required this.works,
    required this.bio,
    required this.email,
    this.image,
    this.onMatch,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double cardWidth = size.width * 0.92;
    final double cardHeight = size.height * 0.85;
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Stack(
            children: [
              // 닫기(X) 아이콘
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.close, size: 30, color: Colors.black),
                  ),
                ),
              ),
              // 이미지 영역
              Positioned(
                left: cardWidth * 0.1,
                top: cardHeight * 0.045,
                child: Container(
                  width: cardWidth * 0.8,
                  height: cardHeight * 0.29,
                  decoration: BoxDecoration(color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(18)),
                  child: image ?? Center(),
                ),
              ),
              // 이름
              Positioned(
                left: cardWidth * 0.15,
                top: cardHeight * 0.36,
                child: SizedBox(
                  width: cardWidth * 0.7,
                  height: cardHeight * 0.09,
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 0.9,
                      ),
                    ),
                  ),
                ),
              ),
              // 상세 정보
              Positioned(
                left: cardWidth * 0.13,
                top: cardHeight * 0.52,
                child: SizedBox(
                  width: cardWidth * 0.77,
                  height: cardHeight * 0.23,
                  child: Text(
                    '기술 : $skill\n\n주요작품 : $works\n\n약력 : $bio\n\n이메일 : $email',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.38,
                    ),
                  ),
                ),
              ),
              // 매칭 신청 버튼
              Positioned(
                left: cardWidth * 0.18,
                top: cardHeight * 0.86,
                child: Button(
                  text: '매칭 신청하기',
                  onPressed: () {
                    final nickname = Provider.of<AuthProvider>(context, listen: false).name ?? '닉네임';
                    final userId = Provider.of<AuthProvider>(context, listen: false).id ?? 0;
                    showDialog(
                      context: context,
                      builder: (_) => Dialog(
                        backgroundColor: Colors.transparent,
                        insetPadding: EdgeInsets.zero,
                        child: RequestNote(nickname: nickname, artisanEmail: email, userId: userId),
                      ),
                    );
                  },
                  width: cardWidth * 0.65,
                  height: 48,
                  backgroundColor: const Color(0xFF9785BA),
                  textColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
