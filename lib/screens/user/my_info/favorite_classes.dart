import 'package:eum_demo/widgets/user/appbar.dart';
import 'package:flutter/material.dart';

class FavoriteClasses extends StatelessWidget {
  const FavoriteClasses({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '관심 등록 클래스'),
      body: const Center(
        child: Text(
          '관심 등록 클래스 내역이 없습니다.',
          style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
