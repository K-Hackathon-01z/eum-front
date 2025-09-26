import 'package:eum_demo/providers/skill_category_provider.dart';
import 'package:eum_demo/providers/career_test_provider.dart';
import 'package:eum_demo/providers/government_provider.dart';
import 'package:eum_demo/providers/my_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:eum_demo/providers/class_data_provider.dart';
import 'package:eum_demo/screens/common/title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClassDataProvider()),
        ChangeNotifierProvider(create: (_) => SkillCategoryProvider()),
        ChangeNotifierProvider(create: (_) => CareerTestProvider()),
        ChangeNotifierProvider(create: (_) => GovernmentProvider()),
        ChangeNotifierProvider(create: (_) => MyInfoProvider()),
      ],
      child: const PreviewApp(child: TitleScreen()),
    ),
  );
}

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
