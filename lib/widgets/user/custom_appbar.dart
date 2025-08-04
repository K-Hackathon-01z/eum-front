import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppBar({required this.title, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Colors.black),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(
        title, // 파라미터로 받아옴
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(15.0),
        child: Container(color: Colors.grey.shade300, height: 1.0),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + 15.0);
}
