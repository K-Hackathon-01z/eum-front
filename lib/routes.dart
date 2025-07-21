import 'package:flutter/material.dart';
import 'screens/common/title.dart';
import 'screens/user/home.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/': (context) => const TitleScreen(),
  '/home': (context) => const RootScreen(),
};
