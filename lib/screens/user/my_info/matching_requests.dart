import 'package:flutter/material.dart';
import 'package:eum_demo/widgets/user/appbar.dart';
import 'package:eum_demo/widgets/user/creator_list.dart';

class MatchingMessageModal extends StatelessWidget {
  const MatchingMessageModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 350,
              height: 610,
              child: Stack(
                children: [
                  Positioned(
                    left: 0,
                    top: 0,
                    child: Container(
                      width: 350,
                      height: 610,
                      decoration: ShapeDecoration(
                        color: const Color(0xFFDAD3E8),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 12,
                    top: 12,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Container(
                        width: 36,
                        height: 36,
                        alignment: Alignment.center,
                        child: const Icon(Icons.close, color: Colors.black54, size: 30),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 5,
                    top: 62,
                    child: Container(
                      width: 342,
                      height: 104,
                      child: Stack(
                        children: [
                          Positioned(
                            left: 26,
                            top: 8,
                            child: Container(
                              width: 289,
                              height: 77,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                              ),
                              child: const Center(
                                child: TextField(
                                  readOnly: true,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    hintText: '매칭 신청 메세지 전송 완료',
                                    hintStyle: TextStyle(color: Colors.purple),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.zero,
                                  ),
                                  maxLines: 1,
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: 32,
                    top: 166,
                    child: Container(
                      width: 289,
                      height: 400,
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      ),
                      child: const Center(
                        child: TextField(
                          readOnly: true,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            hintText: '매칭 신청 부탁드립니다!',
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.zero,
                          ),
                          maxLines: null,
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MatchingRequests extends StatelessWidget {
  const MatchingRequests({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: CustomAppBar(title: '매칭 신청 내역', showBack: true, showHome: true, showSearch: true),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          CreatorList(
            title: '홍길동',
            onTap: () {
              showDialog(context: context, barrierDismissible: true, builder: (_) => const MatchingMessageModal());
            },
          ),
        ],
      ),
    );
  }
}
