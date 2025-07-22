import 'package:flutter/material.dart';

class SkillListScreen extends StatelessWidget {
  const SkillListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('전통 기술 목록')),
      body: Center(child: Text('전통 기술 목록 페이지')),
    );
  }
}
