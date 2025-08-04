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
            // 사용자 정보 보여주기
            ListTile(
              title: Text(
                '사용자 정보',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
            // 비번 변경 제목
            ListTile(
              title: Text('비밀번호 변경하기'),
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
}
