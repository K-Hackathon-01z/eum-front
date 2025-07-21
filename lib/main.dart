import 'package:eum_demo/screens/user/career_test.dart';
import 'package:flutter/material.dart';

import '../widgets/user/navigation.dart';
import 'routes.dart';

// 위젯 파일들은 따로 dart 파일에 두고 import해도 됩니다. 지금은 예시.

// void main() => runApp(const PreviewApp(child: TitleScreen()));
void main() => runApp(
  MaterialApp(
    home: CareerTestScreen(), // ← 여기만 바꿔주면 됨!
    debugShowCheckedModeBanner: false,
  ),
);

// 보고 싶은 위젯은 아래처럼 child에 직접 전달!

// 전체 앱이 아니라, SINGLE 위젯만 centering/배경 등이 적용된 프리뷰 앱!
class PreviewApp extends StatelessWidget {
  final Widget child;
  const PreviewApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
    );
  }
}

// ====== 아래부터는 커스텀 위젯들! ======

class NavigationBarPreview extends StatefulWidget {
  const NavigationBarPreview({super.key});

  @override
  State<NavigationBarPreview> createState() => _NavigationBarPreviewState();
}

class _NavigationBarPreviewState extends State<NavigationBarPreview> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // 선택된 탭 인덱스 표시 (테스트용)
        const SizedBox(height: 24),
        CustomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
        ),
      ],
    );
  }
}
