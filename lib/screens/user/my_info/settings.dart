import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          '설정',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Color(0xFFF5F5F5), // 배경색
        child: Column(
          children: [
            // 사용자 정보 섹션
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '사용자 정보',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  SizedBox(height: 15),
                  _buildMenuItem(
                    title: '비밀번호 변경하기',
                    onTap: () {
                      // 비밀번호 변경 페이지로 이동
                    },
                  ),
                ],
              ),
            ),

            // 구분선
            Container(
              height: 1,
              color: Colors.grey[300],
              margin: EdgeInsets.symmetric(horizontal: 20),
            ),

            // 계정 관리 섹션
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  _buildMenuItem(
                    title: '계정 탈퇴',
                    onTap: () {
                      // 계정 탈퇴 페이지로 이동
                    },
                  ),

                  // 구분선
                  Container(
                    height: 1,
                    color: Colors.grey[300],
                    margin: EdgeInsets.symmetric(vertical: 10),
                  ),

                  _buildMenuItem(
                    title: '로그아웃',
                    onTap: () {
                      // 로그아웃 처리
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem({required String title, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(title, style: TextStyle(color: Colors.black, fontSize: 16)),
            Icon(Icons.arrow_forward_ios, color: Colors.grey[400], size: 16),
          ],
        ),
      ),
    );
  }
}
