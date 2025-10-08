import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utils/validators.dart';
import '../../../widgets/user/button.dart';
import '../../../widgets/user/popup.dart';
import '../../../services/artist/auth_service.dart';
import '../../../models/artist/signup_request.dart';
import '../../../providers/auth_provider.dart';
import 'package:eum_demo/providers/artist_provider.dart';
import 'package:eum_demo/models/artist/artist.dart';

// 아티스트 인증 화면 (로그인/회원가입 탭)
class ArtistAuthScreen extends StatefulWidget {
  const ArtistAuthScreen({super.key});

  @override
  State<ArtistAuthScreen> createState() => _ArtistAuthScreenState();
}

class _ArtistAuthScreenState extends State<ArtistAuthScreen>
    with SingleTickerProviderStateMixin {
  final _loginEmailCtl = TextEditingController();

  // 회원가입
  final _nameCtl = TextEditingController();
  final _emailCtl = TextEditingController();
  final _photoUrlCtl = TextEditingController(text: 'string'); // 기본값 string
  final _mainWorksCtl = TextEditingController();
  final _bioCtl = TextEditingController();
  final _codeCtl = TextEditingController();
  bool _codeSent = false;

  bool _signingUp = false;
  final _service = ArtistAuthService();

  @override
  void dispose() {
    _loginEmailCtl.dispose();
    _nameCtl.dispose();
    _emailCtl.dispose();
    _photoUrlCtl.dispose();
    _mainWorksCtl.dispose();
    _bioCtl.dispose();
    _codeCtl.dispose(); // 추가
    super.dispose();
  }

  // 추가: 이메일 인증코드 전송
  Future<void> _sendCode() async {
    final emailErr = Validators.validateEmail(_emailCtl.text.trim());
    if (emailErr != null) {
      showDialog(
        context: context,
        builder: (_) => CommonPopup(
          icon: Icons.warning_amber_rounded,
          title: '입력 오류',
          message: emailErr,
          button1Text: '확인',
          onButtonFirstPressed: () => Navigator.of(context).pop(),
        ),
      );
      return;
    }
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.requestEmailCode(_emailCtl.text.trim());
    if (!mounted) return;

    if (auth.error != null) {
      showDialog(
        context: context,
        builder: (_) => CommonPopup(
          icon: Icons.warning_amber_rounded,
          title: '오류',
          message: auth.error!,
          button1Text: '확인',
          onButtonFirstPressed: () => Navigator.of(context).pop(),
        ),
      );
      return;
    }
    setState(() => _codeSent = true);
    showDialog(
      context: context,
      builder: (_) => const CommonPopup(
        icon: Icons.check_circle_outline,
        title: '인증코드 발송',
        message: '이메일로 인증코드를 전송했습니다.',
        button1Text: '확인',
      ),
    );
  }

  Future<void> _loadArtistAndGo(String email) async {
    try {
      final Artist artist = await _service.getByEmail(email);
      if (!mounted) return;
      Provider.of<ArtistProvider>(context, listen: false).setCurrent(artist);
      Navigator.pushReplacementNamed(context, '/artist-home');
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => CommonPopup(
          icon: Icons.warning_amber_rounded,
          title: '로그인 실패',
          message: '해당 장인이 존재하지 않습니다',
          button1Text: '확인',
          onButtonFirstPressed: () => Navigator.of(context).pop(),
        ),
      );
    }
  }

  Future<void> _signup() async {
    // 유효성 검사
    final nameErr = Validators.validateName(_nameCtl.text.trim());
    final emailErr = Validators.validateEmail(_emailCtl.text.trim());
    if (nameErr != null || emailErr != null) {
      showDialog(
        context: context,
        builder: (_) => CommonPopup(
          icon: Icons.warning_amber_rounded,
          title: '입력 오류',
          message: nameErr ?? emailErr!,
          button1Text: '확인',
          onButtonFirstPressed: () => Navigator.of(context).pop(),
        ),
      );
      return;
    }
    if (!_codeSent) {
      showDialog(
        context: context,
        builder: (_) => const CommonPopup(
          icon: Icons.info_outline,
          title: '인증 필요',
          message: '먼저 인증코드를 전송하고 인증을 완료해주세요.',
          button1Text: '확인',
        ),
      );
      return;
    }
    final codeErr = Validators.validateAuthCode(_codeCtl.text.trim());
    if (codeErr != null) {
      showDialog(
        context: context,
        builder: (_) => CommonPopup(
          icon: Icons.warning_amber_rounded,
          title: '입력 오류',
          message: codeErr,
          button1Text: '확인',
          onButtonFirstPressed: () => Navigator.of(context).pop(),
        ),
      );
      return;
    }

    // 이메일 인증 확인
    final auth = Provider.of<AuthProvider>(context, listen: false);
    await auth.confirmEmailCode(_emailCtl.text.trim(), _codeCtl.text.trim());
    if (!mounted) return;

    if (auth.error != null || !auth.emailConfirmed) {
      showDialog(
        context: context,
        builder: (_) => CommonPopup(
          icon: Icons.warning_amber_rounded,
          title: '인증 실패',
          message: auth.error ?? '이메일 인증에 실패했습니다. 인증코드를 확인해주세요.',
          button1Text: '확인',
          onButtonFirstPressed: () => Navigator.of(context).pop(),
        ),
      );
      return;
    }

    // skillId = 1 고정, photoUrl은 문자열 그대로 전송
    final req = ArtistSignupRequest(
      skillId: 1,
      email: _emailCtl.text.trim(),
      name: _nameCtl.text.trim(),
      photoUrl: 'string',
      mainWorks: _mainWorksCtl.text.trim(),
      biography: _bioCtl.text.trim(),
    );

    setState(() => _signingUp = true);
    try {
      final ok = await _service.signup(req);
      if (!mounted) return;
      if (ok) {
        await _loadArtistAndGo(_emailCtl.text.trim()); // 가입 후 프로필 적재
      } else {
        showDialog(
          context: context,
          builder: (_) => const CommonPopup(
            icon: Icons.warning_amber_rounded,
            title: '가입 실패',
            message: '서버에서 가입 처리에 실패했습니다.',
            button1Text: '확인',
          ),
        );
      }
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (_) => CommonPopup(
          icon: Icons.warning_amber_rounded,
          title: '에러',
          message: e.toString(),
          button1Text: '확인',
          onButtonFirstPressed: () => Navigator.of(context).pop(),
        ),
      );
    } finally {
      if (mounted) setState(() => _signingUp = false);
    }
  }

  Future<void> _login() async {
    final emailErr = Validators.validateEmail(_loginEmailCtl.text.trim());
    if (emailErr != null) {
      showDialog(
        context: context,
        builder: (_) => CommonPopup(
          icon: Icons.warning_amber_rounded,
          title: '입력 오류',
          message: emailErr,
          button1Text: '확인',
          onButtonFirstPressed: () => Navigator.of(context).pop(),
        ),
      );
      return;
    }
    // 사용자 AuthProvider 이메일 저장 유지
    Provider.of<AuthProvider>(
      context,
      listen: false,
    ).setEmail(_loginEmailCtl.text.trim());
    await _loadArtistAndGo(_loginEmailCtl.text.trim()); // 로그인 시 프로필 적재
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          surfaceTintColor: Colors.transparent,
          elevation: 0,
          title: const Text('작인·작가 인증'),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(text: '로그인'),
              Tab(text: '회원가입'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            // 로그인 탭
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  TextField(
                    controller: _loginEmailCtl,
                    decoration: const InputDecoration(
                      labelText: '이메일',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  Button(
                    text: '로그인',
                    width: double.infinity,
                    height: 48,
                    backgroundColor: const Color(0xFF6D5BD0),
                    textColor: Colors.white,
                    onPressed: _login,
                  ),
                ],
              ),
            ),
            // 회원가입 탭
            SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  TextField(
                    controller: _nameCtl,
                    decoration: const InputDecoration(
                      labelText: '이름',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _emailCtl,
                    decoration: const InputDecoration(
                      labelText: '이메일',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 8),
                  Align(
                    alignment: Alignment.centerRight,
                    child: SizedBox(
                      width: 160,
                      height: 40,
                      child: Button(
                        text: _codeSent ? '인증코드 재전송' : '인증코드 전송',
                        width: 160,
                        height: 40,
                        textColor: Colors.white,
                        backgroundColor: const Color(0xFF6D5BD0), // 통일
                        onPressed: _sendCode,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _codeCtl,
                    decoration: const InputDecoration(
                      labelText: '인증코드',
                      border: OutlineInputBorder(),
                    ),
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _mainWorksCtl,
                    decoration: const InputDecoration(
                      labelText: '주요 작품',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  TextField(
                    controller: _bioCtl,
                    decoration: const InputDecoration(
                      labelText: '약력',
                      border: OutlineInputBorder(),
                    ),
                    maxLines: 4,
                  ),
                  const SizedBox(height: 20),
                  Button(
                    text: _signingUp ? '가입 중...' : '회원가입',
                    width: double.infinity,
                    height: 48,
                    backgroundColor: const Color(0xFF6D5BD0),
                    textColor: Colors.white,
                    onPressed: _signingUp ? null : _signup,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
