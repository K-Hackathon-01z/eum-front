import 'package:flutter/material.dart';
import '../../widgets/user/creator_list.dart';

class CreatorListScreen extends StatelessWidget {
  const CreatorListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        backgroundColor: const Color(0xFFF1F1F1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          '장인 목록',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: -1.2),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.black, size: 32),
            onPressed: () {
              showDialog(
                context: context,
                barrierColor: Colors.black.withOpacity(0.2),
                builder: (context) {
                  return Align(
                    alignment: Alignment.topCenter,
                    child: Material(
                      color: Colors.transparent,
                      child: Container(
                        margin: const EdgeInsets.only(top: 60, left: 20, right: 20),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 8)],
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.search, color: Colors.black54),
                            const SizedBox(width: 8),
                            const Expanded(
                              child: TextField(
                                autofocus: true,
                                decoration: InputDecoration(hintText: '검색어를 입력하세요', border: InputBorder.none),
                              ),
                            ),
                            IconButton(icon: const Icon(Icons.close), onPressed: () => Navigator.of(context).pop()),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1.0),
          child: Container(color: Colors.grey[500], height: 1.0),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        children: [
          CreatorList(title: '무형문화재 000', photoLabel: 'Photo'),
          CreatorList(title: '무형문화재 000', photoLabel: 'Photo'),
          CreatorList(title: '작가 000', photoLabel: 'Photo'),
          CreatorList(title: '무형유산 000', photoLabel: 'Photo'),
          CreatorList(title: '무형유산 000', photoLabel: 'Photo'),
          CreatorList(title: '전수 교육자 000', photoLabel: 'Photo'),
          CreatorList(title: '작가 000', photoLabel: 'Photo'),
          // 7개 반복 × 3세트
          CreatorList(title: '무형문화재 000', photoLabel: 'Photo'),
          CreatorList(title: '무형문화재 000', photoLabel: 'Photo'),
          CreatorList(title: '작가 000', photoLabel: 'Photo'),
          CreatorList(title: '무형유산 000', photoLabel: 'Photo'),
          CreatorList(title: '무형유산 000', photoLabel: 'Photo'),
          CreatorList(title: '전수 교육자 000', photoLabel: 'Photo'),
          CreatorList(title: '작가 000', photoLabel: 'Photo'),
        ],
      ),
    );
  }
}
