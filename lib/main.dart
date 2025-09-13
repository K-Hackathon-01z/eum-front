import 'package:eum_demo/screens/common/title.dart';
import 'package:flutter/material.dart';
import 'routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(const PreviewApp(child: TitleScreen()));

class PreviewApp extends StatelessWidget {
  final Widget child;
  const PreviewApp({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: appRoutes,
      debugShowCheckedModeBanner: false,
      locale: const Locale('ko', 'KR'),
      supportedLocales: const [Locale('ko', 'KR'), Locale('en', 'US')],
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
