import 'package:flutter/material.dart';

import 'favorite_classes.dart';
import 'matching_requests.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
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
            fontSize: 23,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15.0), // 이상하면 나중에 수정!(수동으로 함)
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: Container(
        color: Colors.white, // 배경색
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
            Divider(height: 1, thickness: 1, color: Colors.grey[300]),

            // 계정 관리 섹션
            Divider(height: 1, thickness: 1, color: Colors.grey[300]),
            ListTile(
              title: Text('계정 탈퇴'),
              trailing: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  // 여기서 원하는 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MatchingRequests()),
                  );
                },
              ),
            ),
            Divider(height: 1, thickness: 1, color: Colors.grey[300]),
            ListTile(
              title: Text('로그아웃'),
              trailing: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  // 여기서 원하는 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoriteClasses()),
                  );
                },
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
