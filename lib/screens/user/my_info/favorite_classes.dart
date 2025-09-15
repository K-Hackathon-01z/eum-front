import 'package:eum_demo/widgets/user/custom_appbar.dart';
import 'package:flutter/material.dart';

class FavoriteClasses extends StatelessWidget {
  const FavoriteClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '관심등록 클래스'),
      body: Container(),
    );
  }
}
