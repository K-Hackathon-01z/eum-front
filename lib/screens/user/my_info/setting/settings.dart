import 'package:eum_demo/screens/user/my_info/setting/delete_account.dart';
import 'package:flutter/material.dart';
import 'package:eum_demo/widgets/user/appbar.dart';
import './change_profile.dart';
import 'package:eum_demo/widgets/user/popup.dart';
import 'package:provider/provider.dart';
import 'package:eum_demo/providers/auth_provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: '설정',
        // 수동 보더 라인을 제거하여 AppBar의 elevation 그림자가 자연스럽게 보이도록 함
      ),
      body: Container(
        color: Colors.white, // 배경색
        child: Column(
          children: [
            // 비밀번호 변경 섹션
            ListTile(
              title: Text('사용자 정보 변경하기'),
              trailing: IconButton(
                icon: Icon(Icons.chevron_right),
                onPressed: () {
                  // 여기서 원하는 페이지로 이동
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ChangeProfile()));
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) => DeleteAccount()));
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
                  showDialog(
                    context: context,
                    builder: (_) => CommonPopup(
                      icon: Icons.logout,
                      title: '로그아웃',
                      message: '정말 로그아웃 하시겠습니까?',
                      button1Text: '로그아웃',
                      button2Text: '돌아가기',
                      onButtonFirstPressed: () {
                        Navigator.of(context).pop();
                        // Provider의 모든 사용자 데이터 초기화
                        Provider.of<AuthProvider>(context, listen: false).reset();
                        Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                      },
                      onButtonSecondPressed: () => Navigator.of(context).pop(),
                    ),
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
