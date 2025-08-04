import 'package:flutter/material.dart';

class FavoriteClasses extends StatelessWidget {
  const FavoriteClasses({super.key});

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
          '관심등록 클래스',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(15.0), // 이상하면 나중에 수정!(수동으로 함)
          child: Container(color: Colors.grey.shade300, height: 1.0),
        ),
      ),
      body: Container(),
    );
  }
}
