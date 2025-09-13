import 'package:flutter/material.dart';

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
    return ListView(
      children: [
        // TODO: API 연동 시 실제 프로필 데이터로 대체 (현재 더미 데이터)
        _section('내 정보', [
          _row('이름', '홍길동'),
          _row('전문 분야', '목공'),
          _row('지역', '서울시 강서구'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _todo(context),
            child: const Text('프로필 수정'),
          ),
        ]),
        // TODO: 실명 인증/사업자 연동 화면 연결 필요
        _section('인증 및 사업자 정보', [
          ElevatedButton(
            onPressed: () => _todo(context),
            child: const Text('신원 인증'),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () => _todo(context),
            child: const Text('사업자 등록/연동'),
          ),
        ]),
        _section('접근성 설정', [
          SwitchListTile(
            title: const Text('고대비 모드'),
            value: highContrast,
            onChanged: onHighContrastChanged,
          ),
          ListTile(
            title: const Text('글자 크기'),
            subtitle: Text(textScale >= 1.2 ? '크게' : '보통'),
            trailing: SegmentedButton<double>(
              segments: const [
                ButtonSegment(value: 1.0, label: Text('보통')),
                ButtonSegment(value: 1.2, label: Text('크게')),
                ButtonSegment(value: 1.35, label: Text('아주 크게')),
              ],
              selected: {textScale},
              onSelectionChanged: (s) => onTextScaleChanged(s.first),
            ),
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          a,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
        Text(
          b,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ],
    ),
  );

  void _todo(BuildContext context) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('API 연동이 필요한 기능입니다.')));
  }
}
