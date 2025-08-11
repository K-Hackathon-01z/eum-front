import 'package:flutter/material.dart';

class GovernmentHelpScreen extends StatelessWidget {
  const GovernmentHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('정부 지원 혜택')),
      body: Center(child: Text('정부 지원 혜택 페이지')),
    );
  }
}
