import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';
import 'package:eum_demo/providers/artist_provider.dart';
import 'package:eum_demo/providers/artist_matching_request_provider.dart';
import 'package:eum_demo/widgets/user/popup.dart';
import 'package:eum_demo/services/artist/artist_info_service.dart';

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
            onPressed: () => _openEditDialog(context), // 수정 다이얼로그
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF6D5BD0),
            ),
            child: const Text('프로필 수정', style: TextStyle(color: Colors.white)),
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

  void _openEditDialog(BuildContext context) {
    final artist = context.read<ArtistProvider>().current;
    if (artist == null) return;

    final mainCtl = TextEditingController(text: artist.mainWorks);
    final bioCtl = TextEditingController(text: artist.biography);
    final service = ArtistService();

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('프로필 수정'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: mainCtl,
                decoration: const InputDecoration(
                  labelText: '주요 작품',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: bioCtl,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: '약력',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('취소'),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color(0xFF6D5BD0),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              final mainWorks = mainCtl.text.trim();
              final biography = bioCtl.text.trim();
              try {
                await service.updateProfile(
                  id: artist.id,
                  mainWorks: mainWorks,
                  biography: biography,
                );
                // 전역 상태 갱신
                context.read<ArtistProvider>().updateProfile(
                  mainWorks: mainWorks,
                  biography: biography,
                  photoUrl: 'string',
                );
                if (context.mounted) {
                  // 1) 수정 다이얼로그 닫기
                  Navigator.pop(dialogContext);
                  // 2) 완료 팝업 띄우기
                  showDialog(
                    context: context,
                    builder: (popCtx) => CommonPopup(
                      icon: Icons.check_circle_outline,
                      title: '저장 완료',
                      message: '프로필이 수정되었습니다.',
                      button1Text: '확인',
                      button1Color: Color(0xFF6D5BD0),
                      onButtonFirstPressed: () =>
                          Navigator.pop(popCtx), // 확인 시 팝업 닫기
                    ),
                  );
                }
              } catch (e) {
                if (!context.mounted) return;
                showDialog(
                  context: dialogContext,
                  builder: (errCtx) => CommonPopup(
                    icon: Icons.warning_amber_rounded,
                    title: '오류',
                    message: '수정 실패: $e',
                    button1Text: '확인',
                    onButtonFirstPressed: () => Navigator.pop(errCtx),
                  ),
                );
              }
            },
            child: const Text('완료'),
          ),
        ],
      ),
    );
  }
}
