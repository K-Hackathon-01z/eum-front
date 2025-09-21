import 'package:flutter/material.dart';
import 'dashboard.dart';
import 'classes.dart';
import 'messages.dart';
import 'profile.dart';

class ArtistShellScreen extends StatefulWidget {
  const ArtistShellScreen({super.key});

  @override
  State<ArtistShellScreen> createState() => _ArtistShellScreenState();
}

class _ArtistShellScreenState extends State<ArtistShellScreen> {
  int _currentIndex = 0;
  bool _tabHandled = false;

  double _textScale = 1.2; // 큰 글씨 기본값
  bool _highContrast = true; // 고대비 기본값

  ThemeData _theme(BuildContext context) {
    final base = Theme.of(context);
    final colorScheme = _highContrast
        ? ColorScheme.fromSeed(
            seedColor: const Color(0xFF6D5BD0),
            brightness: Brightness.light,
            primary: const Color(0xFF5A48C5),
            onPrimary: Colors.white,
            secondary: const Color(0xFFEBA0A0),
            onSecondary: Colors.white,
            // background: Colors.white,
            // onBackground: Colors.black,
            surface: Colors.white,
            onSurface: Colors.black,
          )
        : base.colorScheme;

    return base.copyWith(
      colorScheme: colorScheme,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: base.appBarTheme.copyWith(
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 22 * _textScale,
          fontWeight: FontWeight.w800,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        selectedItemColor: colorScheme.primary,
        unselectedItemColor: Colors.black54,
        selectedIconTheme: const IconThemeData(size: 28),
        unselectedIconTheme: const IconThemeData(size: 26),
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: Colors.black,
        displayColor: Colors.black,
      ),
    );
  }

  List<Widget> _pages() => [
    DashboardPage(highContrast: _highContrast),
    const ClassesPage(),
    MessagesPage(),
    ProfilePage(
      textScale: _textScale,
      highContrast: _highContrast,
      onTextScaleChanged: (v) => setState(() => _textScale = v),
      onHighContrastChanged: (v) => setState(() => _highContrast = v),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    if (!_tabHandled) {
      final args = ModalRoute.of(context)?.settings.arguments;
      if (args is Map && args['tab'] is int) {
        _currentIndex = args['tab'];
      }
      _tabHandled = true;
    }
    final pages = _pages();
    return Theme(
      data: _theme(context),
      child: MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: _textScale),
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false, 
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6D5BD0), Color(0xFF9785BA)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
            title: const Text('장인 모드'),
          ),
          body: SafeArea(
            child: IndexedStack(index: _currentIndex, children: pages),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (i) => setState(() => _currentIndex = i),
            type: BottomNavigationBarType.fixed,
            selectedFontSize: 13 * _textScale,
            unselectedFontSize: 12 * _textScale,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.dashboard_rounded),
                label: '대시보드',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.class_rounded),
                label: '클래스',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.chat_bubble_rounded),
                label: '쪽지함',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: '내 정보',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
