import 'package:flutter/material.dart';

/// 커스텀 AppBar 위젯
/// [title]: 앱바 중앙 제목
/// [showBack], [showHome], [showSearch]: 각 아이콘 표시 여부
/// [onBack], [onHome], [onSearch]: 각 아이콘 클릭 시 콜백(필요시)
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool showBack;
  final bool showHome;
  final bool showSearch;
  final VoidCallback? onBack;
  final VoidCallback? onHome;
  final VoidCallback? onSearch;

  const CustomAppBar({
    Key? key,
    required this.title,
    this.showBack = false,
    this.showHome = false,
    this.showSearch = false,
    this.onBack,
    this.onHome,
    this.onSearch,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      surfaceTintColor: Colors.transparent,
      backgroundColor: const Color.fromARGB(255, 255, 255, 255),
      elevation: 0,
      leading: showBack
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            )
          : null,
      title: Text(
        title,
        style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -1.2),
      ),
      centerTitle: true,
      actions: [
        if (showHome)
          IconButton(
            icon: const Icon(Icons.home, color: Colors.black, size: 28),
            onPressed:
                onHome ??
                () {
                  Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
                },
          ),
        if (showSearch)
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 32),
            onPressed: onSearch,
          ),
      ],
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(1.0),
        child: Divider(height: 1, thickness: 1, color: Color(0xFFE0E0E0)),
      ),
    );
  }
}
