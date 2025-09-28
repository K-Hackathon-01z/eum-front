import 'package:eum_demo/screens/user/my_info/favorite_classes.dart';
import 'package:eum_demo/screens/user/my_info/matching_requests.dart';
import 'package:eum_demo/screens/user/my_info/setting/settings.dart';
import 'package:eum_demo/screens/user/my_info/usage_history.dart';
import 'package:flutter/material.dart';
import '../../../services/user/my_info_service.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import 'package:eum_demo/widgets/user/appbar.dart';

class MyInfoScreen extends StatefulWidget {
  const MyInfoScreen({super.key});

  @override
  State<MyInfoScreen> createState() => _MyInfoScreenState();
}

class _MyInfoScreenState extends State<MyInfoScreen> {
  String? name;
  int? age;
  String? address;
  String? gender;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchUserInfo();
    });
  }

  Future<void> _fetchUserInfo() async {
    final email = Provider.of<AuthProvider>(context, listen: false).email;
    if (email == null || email.isEmpty) return;
    final data = await MyInfoService.getUserByEmail(email);
    setState(() {
      name = data['name'];
      address = data['address'];
      age = data['age'];
      gender = data['gender'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '내 정보',
        showSettings: true,
        onSettings: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => SettingsScreen()));
        },
      ),
      body: Column(
        children: [
          // 프로필 카드
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              decoration: BoxDecoration(color: Color(0xFFF7F7F7), borderRadius: BorderRadius.circular(25)),
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
                            Text(name ?? "-", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                            Spacer(),
                            Text(
                              '${age?.toString() ?? "-"}세',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.normal),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            Text(address ?? "-", style: TextStyle(fontSize: 14, color: Colors.black54)),
                            Spacer(),
                            Text(gender ?? "-", style: TextStyle(fontSize: 14, color: Colors.black54)),
                          ],
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

  @override
  void dispose() {
    // 컨트롤러/스트림 정리
    super.dispose();
  }
}
