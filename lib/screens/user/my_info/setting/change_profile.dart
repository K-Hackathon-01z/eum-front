import 'package:eum_demo/widgets/user/appbar.dart';
import 'package:flutter/material.dart';

class ChangeProfile extends StatelessWidget {
  const ChangeProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '사용자 정보 변경하기'),
      body: Container(),
    );
  }
}
