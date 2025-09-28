import 'package:eum_demo/widgets/user/appbar.dart';
import 'package:flutter/material.dart';

class ChangePassword extends StatelessWidget {
  const ChangePassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '비밀번호 변경'),
      body: Container(),
    );
  }
}
