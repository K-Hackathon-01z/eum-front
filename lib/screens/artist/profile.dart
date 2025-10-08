import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:eum_demo/providers/artist_provider.dart';
import 'package:eum_demo/providers/artist_matching_request_provider.dart';
import 'package:eum_demo/widgets/user/popup.dart'; // 추가: 공용 다이얼로그

class ProfilePage extends StatelessWidget {
  final double textScale;
  final bool highContrast;
  final ValueChanged<double> onTextScaleChanged;
  final ValueChanged<bool> onHighContrastChanged;

  const ProfilePage({
    super.key,
    required this.textScale,
    required this.highContrast,
    required this.onTextScaleChanged,
    required this.onHighContrastChanged,
  });

  @override
  Widget build(BuildContext context) {
    final artist = context.watch<ArtistProvider>().current;

    return ListView(
      children: [
        _section('내 정보', [
          _row('이름', artist?.name ?? '-'),
          // 사진 URL은 표시/사용하지 않음
          // _row('전문 분야', (artist?.skillId ?? 0).toString()),
          _row(
            '주요 작품',
            artist?.mainWorks.isNotEmpty == true ? artist!.mainWorks : '-',
          ),
          _row(
            '약력',
            artist?.biography.isNotEmpty == true ? artist!.biography : '-',
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _todo(context),
            child: const Text('프로필 수정', style: TextStyle(color: Colors.white)),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6D5BD0),
            ),
          ),
        ]),
        const SizedBox(height: 16),
        _section('접근성 설정', [
          SwitchListTile(
            title: const Text('고대비 모드'),
            value: highContrast,
            onChanged: onHighContrastChanged,
          ),
          ListTile(
            title: const Text('글자 크기'),
            trailing: SegmentedButton<double>(
              segments: const [
                ButtonSegment(value: 1.0, label: Text('보통')),
                ButtonSegment(value: 1.2, label: Text('크게')),
                ButtonSegment(value: 1.35, label: Text('아주 크게')),
              ],
              selected: {textScale},
              onSelectionChanged: (s) {
                if (s.isEmpty) return;
                final v = s.first;
                if (v == textScale) return;
                SchedulerBinding.instance.addPostFrameCallback((_) {
                  onTextScaleChanged(v);
                });
              },
            ),
          ),
        ]),
        const SizedBox(height: 16),
        _section('계정', [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6D5BD0),
            ),
            onPressed: () => _confirmLogout(context), // 변경: 확인 다이얼로그
            child: const Text('로그아웃', style: TextStyle(color: Colors.white)),
          ),
        ]),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _section(String title, List<Widget> children) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
    color: highContrast ? Colors.white : null,
    child: Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w800),
          ),
          const SizedBox(height: 14),
          ...children,
        ],
      ),
    ),
  );

  Widget _row(String a, String b) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 6),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Text(
            a,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: 12),
        Flexible(
          child: Align(
            alignment: Alignment.centerRight,
            child: Text(
              b,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              textAlign: TextAlign.right,
            ),
          ),
        ),
      ],
    ),
  );

  void _todo(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('API 연동이 필요한 기능입니다.')));
  }

  // 추가: 로그아웃 확인 다이얼로그
  void _confirmLogout(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => CommonPopup(
        icon: Icons.logout,
        title: '로그아웃',
        message: '정말 로그아웃 하시겠습니까?',
        button1Text: '로그아웃',
        button2Text: '취소',
        onButtonFirstPressed: () {
          Navigator.of(context).pop(); // 다이얼로그 닫기
          _logout(context); // 실제 로그아웃
        },
        onButtonSecondPressed: () => Navigator.of(context).pop(),
      ),
    );
  }

  void _logout(BuildContext context) {
    // 아티스트 모드 상태 정리
    context.read<ArtistProvider>().reset();
    context.read<MatchingRequestProvider>().reset();
    // 초기 타이틀 스크린로 이동
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
  }
}
