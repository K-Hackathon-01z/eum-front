import 'package:flutter/material.dart';
import '../../../../widgets/user/button.dart';
import '../../../../widgets/user/calendar.dart';

class CardDetailScreen extends StatefulWidget {
  final String? imageUrl;
  final String title;
  final String desc;
  final String price;
  final String region;
  final int capacity;
  final int interest;

  const CardDetailScreen({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.desc,
    required this.price,
    required this.region,
    required this.capacity,
    required this.interest,
  });

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen> {
  bool isLiked = false;
  late int interestCount;
  late int capacity;

  @override
  void initState() {
    super.initState();
    interestCount = widget.interest;
    capacity = widget.capacity;
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
            width: screenWidth < 420 ? screenWidth : 420,
            decoration: BoxDecoration(color: Colors.white),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // 이미지 (카드에서 전달된 asset 이미지가 있으면 표시)
                (widget.imageUrl != null && widget.imageUrl!.isNotEmpty && widget.imageUrl!.endsWith('.png'))
                    ? Image.asset(widget.imageUrl!, height: 240, width: double.infinity, fit: BoxFit.cover)
                    : Container(height: 240, color: const Color(0xFFD9D9D9), alignment: Alignment.center),
                // 설명/가격/지역 등
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 10),
                      Text(widget.desc, style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 10),
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
                          Text('수용 인원 : $capacity 명', style: const TextStyle(fontSize: 15, color: Colors.black54)),
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
                    backgroundColor: const Color(0xFFD9D9D9),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                        ),
                        builder: (context) => Padding(
                          padding: MediaQuery.of(context).viewInsets,
                          child: CalendarWidget(
                            onSelected: (date, time) {
                              // 예약 처리 로직 추가 가능
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      );
                    },
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
