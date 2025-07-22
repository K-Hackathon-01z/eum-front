import 'package:flutter/material.dart';

class CreatorListScreen extends StatelessWidget {
  const CreatorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('장인 목록')),
      body: Center(child: Text('장인 목록 페이지')),
    );
  }
}
