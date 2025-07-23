import 'package:flutter/material.dart';

class MyInfoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyInfoPage(), debugShowCheckedModeBanner: false);
  }
}

class MyInfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Icon(Icons.arrow_back, color: Colors.black),
        title: Text(
          '내 정보',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Icon(Icons.settings, color: Colors.black),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          // 프로필 카드
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFF7F7F7),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.blueAccent),
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
                            Text(
                              '닉네임',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '(25세)',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          '주소 예시입니다. 한 줄로 입력됩니다.',
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
            title: Text('이용 내역'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          ListTile(
            title: Text('매칭 신청 내역'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
          Divider(height: 1, thickness: 1, color: Colors.grey[300]),
          ListTile(
            title: Text('나의 관심 등록 클래스'),
            trailing: Icon(Icons.chevron_right),
            onTap: () {},
          ),
        ],
      ),
      // 하단 네비게이션 바
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 4,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.do_not_disturb_on),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: false,
        showUnselectedLabels: false,
      ),
    );
  }
}
