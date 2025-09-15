import 'package:eum_demo/widgets/user/custom_appbar.dart';
import 'package:flutter/material.dart';

class MatchingRequests extends StatelessWidget {
  const MatchingRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '나의 신청 내역'),
      body: Container(),
    );
  }
}