import 'package:flutter/material.dart';

class GovernmentHelpScreen extends StatelessWidget {
  const GovernmentHelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '정부 지원 혜택',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -1.2),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[500], height: 1.0),
        ),
      ),
      body: const Center(child: Text('정부 지원 혜택 페이지')),
    );
  }
}
