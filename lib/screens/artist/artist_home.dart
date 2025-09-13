import 'package:flutter/material.dart';
import 'package:eum_demo/widgets/user/button.dart';

class ArtistHomeScreen extends StatelessWidget {
  const ArtistHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF9FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.5,
        centerTitle: true,
        title: const Text(
          '장인 모드',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 8),
              _BigTile(
                icon: Icons.post_add,
                title: '수업 등록하기',
                subtitle: '사진과 설명을 간단히 올려요',
                onTap: () {
                  // TODO: 수업 등록 화면으로 이동
                },
              ),
              const SizedBox(height: 16),
              _BigTile(
                icon: Icons.inbox_outlined,
                title: '신청/문의 확인',
                subtitle: '들어온 요청을 한눈에 봐요',
                onTap: () {
                  // TODO: 신청 관리 화면으로 이동
                },
              ),
              const SizedBox(height: 16),
              _BigTile(
                icon: Icons.person_outline,
                title: '내 정보 관리',
                subtitle: '연락처, 계정, 정산 정보',
                onTap: () {
                  // TODO: 내 정보 관리로 이동
                },
              ),
              const Spacer(),
              Button(
                text: '도움이 필요하신가요? 1:1 도우미',
                width: double.infinity,
                height: 56,
                backgroundColor: const Color(0xFF4A5568),
                textColor: Colors.white,
                onPressed: () {
                  // TODO: 도움말/상담 연결
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BigTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _BigTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: title,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Ink(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(icon, size: 36, color: const Color(0xFF374151)),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Color(0xFF6B7280),
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(
                Icons.chevron_right,
                size: 36,
                color: Color(0xFF9CA3AF),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
