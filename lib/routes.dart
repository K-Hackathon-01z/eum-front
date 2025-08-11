import 'package:flutter/material.dart';

import 'screens/common/title.dart';
import 'screens/user/home/creator_list/creator_list_screen.dart';
import 'screens/user/home/oneday_class/oneday_class.dart';
import 'screens/user/home/goverment/government_help.dart';
import 'screens/user/home/home.dart';
import 'screens/user/home/skill_list/skill_list_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const TitleScreen(),
  '/home': (context) => const RootScreen(),
  '/government-help': (context) => const GovernmentHelpScreen(),
  '/skill-list': (context) => const SkillListScreen(),
  '/creator-list': (context) => const CreatorListScreen(),
  '/oneday-class': (context) => const OnedayClassScreen(),
  //'/card-detail': (context) => const CardDetailScreen(), 생성자 데이터가 필수이기에 라우팅에서 제외
};
