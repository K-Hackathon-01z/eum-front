import 'package:flutter/material.dart';
import '../../widgets/user/button.dart';

class CardDetailScreen extends StatefulWidget {
  final String imageUrl;
  final String desc;
  final String price;
  final String region;
  final int capacity;
  final int interest;

  const CardDetailScreen({
    super.key,
    required this.imageUrl,
    required this.desc,
    required this.price,
    required this.region,
    this.capacity = 0,
    this.interest = 0,
  });

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  bool isLiked = false;
  int interestCount = 0;

  @override
  void initState() {
    super.initState();
    interestCount = widget.interest;
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          '클래스 상세',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              isLiked ? Icons.favorite : Icons.favorite_border,
              color: isLiked ? const Color(0xFFEBA0A0) : Colors.black26,
            ),
            onPressed: () {
              setState(() {
                if (isLiked) {
                  isLiked = false;
                  interestCount = (interestCount > 0) ? interestCount - 1 : 0;
                } else {
                  isLiked = true;
                  interestCount++;
                }
              });
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 24, horizontal: 8),
            width: screenWidth < 420 ? screenWidth : 402,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 이미지 (oneday_class 카드 썸네일 스타일)
                ClipRRect(
                  child: Container(
                    height: 240,
                    color: const Color(0xFFD9D9D9),
                    alignment: Alignment.center,
                    child: const Text(
                      'Photo',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -1.2,
                      ),
                    ),
                  ),
                ),
                // 설명/가격/지역 등
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.desc, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 16),
                      Text(widget.price, style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          const Icon(Icons.place, size: 20, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(widget.region, style: const TextStyle(fontSize: 15, color: Colors.black54)),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.people, size: 20, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text(
                            '수용 인원 : ${widget.capacity} 명',
                            style: const TextStyle(fontSize: 15, color: Colors.black54),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.favorite_border, size: 20, color: Colors.grey),
                          const SizedBox(width: 6),
                          Text('관심 등록 : $interestCount 명', style: const TextStyle(fontSize: 15, color: Colors.black54)),
                        ],
                      ),
                    ],
                  ),
                ),
                // 예약 버튼 (커스텀 Button 위젯 사용)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  child: Button(
                    text: '예약하기',
                    width: double.infinity,
                    height: 48,
                    color: const Color(0xFFD9D9D9),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
