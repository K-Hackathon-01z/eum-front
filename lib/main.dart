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
import 'providers/user_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/creator_provider.dart';
import 'providers/artist_provider.dart';
import 'providers/artist_matching_request_provider.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';
import 'providers/sent_note_provider.dart';
import 'providers/send_note_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: '.env');

  // Google Maps Android 설정 (선택사항, 성능 향상에 도움)
  final GoogleMapsFlutterPlatform mapsImplementation = GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    mapsImplementation.useAndroidViewSurface = true;
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClassDataProvider()),
        ChangeNotifierProvider(create: (_) => SkillCategoryProvider()),
        ChangeNotifierProvider(create: (_) => CareerTestProvider()),
        ChangeNotifierProvider(create: (_) => GovernmentProvider()),
        ChangeNotifierProvider(create: (_) => MyInfoProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => CreatorProvider()),
        ChangeNotifierProvider(create: (_) => SentNoteProvider()),
        ChangeNotifierProvider(create: (_) => SendNoteProvider()),
        // artist 모드
        ChangeNotifierProvider(create: (_) => ArtistProvider()),
        ChangeNotifierProvider(create: (_) => MatchingRequestProvider()),
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
      theme: ThemeData.light(),
      themeMode: ThemeMode.system,
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
