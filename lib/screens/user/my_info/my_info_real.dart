import 'package:eum_demo/screens/user/my_info/favorite_classes.dart';
import 'package:eum_demo/screens/user/my_info/matching_requests.dart';
import 'package:eum_demo/screens/user/my_info/setting/settings.dart';
import 'package:eum_demo/screens/user/my_info/usage_history.dart';
import 'package:flutter/material.dart';

import '../../../services/user/my_info_service.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  String? name;
  int? age;
  String? address;

  @override
  void initState() {
    super.initState();
    _fetch(); // 라이프사이클 시작 시 한 번
  }


  //나중에 뺴야함
  Future<void> _fetch() async {
    final data = await MyInfoService.getUserByEmail("daniel010203@naver.com");
    setState(() {
      name = data['name'];
      address = data['address'];
      final rawAge = data['age'];
      age = rawAge;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1, // 그림자 강도 약간 증가
        surfaceTintColor: Colors.transparent, // Material3 틴트 제거로 순수한 색/그림자 유지
        shadowColor: Colors.black26, // 그림자 색상 명시
        title: Text(
          '내 정보',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings, size: 32),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsScreen()),
              );
            },
          ),
          SizedBox(width: 16),
        ],
        // 수동 보더 라인을 제거하여 AppBar의 elevation 그림자가 자연스럽게 보이도록 함
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
                          // 이름,나이, 주소 , 사진등
                          children: [
                            Text(
                              name ?? "-",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${age?.toString() ?? "-"}세',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          address ?? "-",
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
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
            title: Text('이용내역'),
            trailing: IconButton(
              icon: Icon(Icons.chevron_right),
              onPressed: () {
                // 여기서 원하는 페이지로 이동
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UsageHistory()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MatchingRequests()),
                );
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
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FavoriteClasses()),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    // 컨트롤러/스트림 정리
    super.dispose();
  }
}
