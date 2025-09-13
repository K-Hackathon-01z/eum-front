import 'package:eum_demo/screens/user/my_info/setting/change_password.dart';
import 'package:eum_demo/screens/user/my_info/setting/delete_account.dart';
import 'package:eum_demo/widgets/user/custom_appbar.dart';
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(title: '설정'),
      body: Container(
        color: Colors.white, // 배경색
        child: Column(
          children: [
            // 이건 그냥 제목
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

            // 비밀번호 변경 섹션
            ListTile(
              title: Text('비밀번호 변경하기'),
              trailing: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  // 여기서 원하는 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ChangePassword()),
                  );
                },
              ),
            ),

            Divider(height: 1, thickness: 1, color: Colors.grey[300]),
            // 계정 탈퇴
            ListTile(
              title: Text('계정 탈퇴'),
              trailing: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  // 여기서 원하는 페이지로 이동
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DeleteAccount()),
                  );
                },
              ),
            ),

            Divider(height: 1, thickness: 1, color: Colors.grey[300]),
            // 로그아웃
            ListTile(
              title: Text('로그아웃'),
              trailing: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  // 여기서 원하는 페이지로 이동
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('로그아웃', textAlign: TextAlign.center),
                        content: Text(
                          '정말 로그아웃 하시겠습니까?',
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop(); // 창 닫기
                                },
                                child: Text('닫기'),
                              ),
                              SizedBox(width: 30), // 숫자를 낮추면 가까워짐 (ex. 1~2)
                              TextButton(
                                onPressed: () {
                                  // 1) 모달 닫고
                                  Navigator.of(context).pop();
                                  // 2) 네비게이션 스택 초기화 후 홈으로 이동
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    '/',
                                    (route) => false,
                                  );
                                },
                                child: Text('로그아웃'),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
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
