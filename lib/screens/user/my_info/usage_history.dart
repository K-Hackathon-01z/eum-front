import 'package:eum_demo/widgets/user/appbar.dart';
import 'package:flutter/material.dart';

class UsageHistory extends StatelessWidget {
  const UsageHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '예약 내역'),
      body: const Center(
        child: Text(
          '예약 내역이 없습니다.',
          style: TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w500),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
