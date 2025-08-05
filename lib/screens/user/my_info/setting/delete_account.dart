import 'package:eum_demo/widgets/user/custom_appbar.dart';
import 'package:flutter/material.dart';

class DeleteAccount extends StatelessWidget {
  const DeleteAccount({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '계정 탈퇴'),
      body: Container(),
    );
  }
}
