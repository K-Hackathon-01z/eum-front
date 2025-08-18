import 'package:eum_demo/screens/user/my_info/favorite_classes.dart';
import 'package:eum_demo/screens/user/my_info/matching_requests.dart';
import 'package:eum_demo/screens/user/my_info/setting/settings.dart';
import 'package:eum_demo/screens/user/my_info/usage_history.dart';
import 'package:flutter/material.dart';

class MyInfoApp extends StatelessWidget {
  const MyInfoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyInfoScreen(), debugShowCheckedModeBanner: false);
  }
}

class MyInfoScreen extends StatelessWidget {
  const MyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          '내 정보',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, size: 32),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
            },
          ),
          SizedBox(width: 16),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[300], height: 1.0),
        ),
      ),
      body: Column(
        children: [
          // 프로필 카드
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(25),
                //border: Border.all(color: Colors.blueAccent),
              ),
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 32,
                    backgroundColor: Colors.grey[300],
                    child: Icon(Icons.person, size: 40, color: Colors.grey),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text('JunHoKim', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            Spacer(),
                            Text(
                              '',
                              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text('서울시 광진구', style: TextStyle(fontSize: 14, color: Colors.black54)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // 구분선
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          // 메뉴 리스트
          ListTile(
            title: Text('클래스 예약 내역'),
            trailing: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                // 여기서 원하는 페이지로 이동
                Navigator.push(context, MaterialPageRoute(builder: (context) => UsageHistory()));
              },
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          ListTile(
            title: Text('매칭 신청 내역'),
            trailing: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                // 여기서 원하는 페이지로 이동
                Navigator.push(context, MaterialPageRoute(builder: (context) => MatchingRequests()));
              },
            ),
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          ListTile(
            title: Text('나의 관심 등록 클래스'),
            trailing: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                // 여기서 원하는 페이지로 이동
                Navigator.push(context, MaterialPageRoute(builder: (context) => FavoriteClasses()));
              },
            ),
          ),
        ],
      ),
    );
  }
}
