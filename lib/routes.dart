import 'package:flutter/material.dart';

import 'screens/common/title.dart';
import 'screens/artist/artist_intro.dart';
import 'screens/artist/artist_shell.dart';
import 'screens/user/home/creator_list/creator_list_screen.dart';
import 'screens/user/home/oneday_class/oneday_class.dart';
import 'screens/user/home/goverment/government_help.dart';
import 'screens/user/home/home.dart';
import 'screens/user/home/skill_list/skill_list_screen.dart';
import 'screens/user/my_info/my_info_real.dart';
import 'screens/user/signup/nickname_signup_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const TitleScreen(),
  '/home': (context) => const RootScreen(),
  '/government-help': (context) => const GovernmentHelpScreen(),
  '/skill-list': (context) => const SkillListScreen(),
  '/creator-list': (context) => const CreatorListScreen(),
  '/oneday-class': (context) => const OnedayClassScreen(),
  '/my-info': (context) => const MyInfoScreen(),
  '/signup-nickname': (context) => const NicknameSignupScreen(),
  // Artist mode
  '/artist-intro': (context) => const ArtistIntroScreen(),
  '/artist-home': (context) => const ArtistShellScreen(),
};
