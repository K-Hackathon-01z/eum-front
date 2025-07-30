import 'package:eum_demo/screens/common/title.dart';
import 'package:flutter/material.dart';

import 'routes.dart';

// 위젯 파일들은 따로 dart 파일에 두고 import해도 됩니다. 지금은 예시.

void main() => runApp(const PreviewApp(child: TitleScreen()));
// void main() {
//   runApp(
//     MaterialApp(
//       debugShowCheckedModeBanner: false, //
//       home: MyInfoPage(), // ← 테스트할 위젯
//     ),
//   );
// }
//보고 싶은 위젯은 아래처럼 child에 직접 전달!

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
