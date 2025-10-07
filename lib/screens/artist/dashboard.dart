import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  final bool highContrast;
  const DashboardPage({super.key, required this.highContrast});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return ListView(
      children: [
        // 상단 인사 + 퀵 액션
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6D5BD0), Color(0xFF9785BA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '좋은 하루예요 👋',
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  '오늘도 멋진 작업을 함께해요',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 14),
                Row(
                  children: [
                    _quick(cs, Icons.event_available_rounded, '일정'),
                    const SizedBox(width: 10),
                    _quick(cs, Icons.class_rounded, '클래스'),
                  ],
                ),
              ],
            ),
          ),
        ),

        _section(context, '오늘 일정', [
          // TODO: API 연동 시 실제 일정 데이터로 대체 (더미 데이터)
          _row('10:00', '원데이 클래스 — 목공 기초'),
          _row('14:00', '의뢰 상담 — 맞춤 선반'),
          _row('16:30', '자재 수령'),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: () {}, child: const Text('일정 전체 보기')),
        ], highContrast),

        _section(context, '수익 요약', [
          // API 연동 시 실제 정산/매출 데이터로 대체 (더미 데이터)
          _row('이번 주 예상 정산', '₩ 0'),
          _row('이번 달 매출', '₩ 0'),
          const SizedBox(height: 8),
          ElevatedButton(onPressed: () {
            // 정산 내역 보기 기능 구현
          }, child: const Text('정산 내역 보기')),
        ], highContrast),

        const SizedBox(height: 16),
      ],
    );
  }

  Widget _row(String a, String b) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          a,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        Text(
          b,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
        ),
      ],
    ),
  );

  // 의뢰함 제거에 따라 사용되지 않는 칩 위젯 제거됨

  Widget _section(
    BuildContext context,
    String title,
    List<Widget> children,
    bool hc,
  ) => Card(
    color: hc ? Colors.white : null,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.circle,
                size: 8,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    ),
  );

  Widget _quick(ColorScheme cs, IconData icon, String label) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.15),
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white, size: 20),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
