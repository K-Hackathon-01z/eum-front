import 'package:eum_demo/widgets/user/custom_appbar.dart';
import 'package:flutter/material.dart';

class UsageHistory extends StatelessWidget {
  const UsageHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '클래스 예약 내역'),
      body: Container(),
    );
  }
}
