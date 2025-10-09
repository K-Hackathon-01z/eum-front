import 'package:flutter/material.dart';

class SkillDetail extends StatelessWidget {
  final String name;
  final String category;
  final String description;
  final String careerPath;
  final String image_url;

  const SkillDetail({
    super.key,
    required this.name,
    required this.category,
    required this.description,
    required this.careerPath,
    required this.image_url,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double cardWidth = size.width * 0.92;
    final double cardHeight = size.height * 0.85;
    return Center(
      child: SingleChildScrollView(
        child: Container(
          width: cardWidth,
          height: cardHeight,
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(30)),
          child: Stack(
            children: [
              // 닫기(X) 아이콘
              Positioned(
                right: 10,
                top: 10,
                child: GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                    child: const Icon(Icons.close, size: 30, color: Colors.black),
                  ),
                ),
              ),
              // 이미지 영역
              Positioned(
                left: cardWidth * 0.1,
                top: cardHeight * 0.045,
                child: Container(
                  width: cardWidth * 0.8,
                  height: cardHeight * 0.29,
                  decoration: BoxDecoration(color: const Color(0xFFD9D9D9), borderRadius: BorderRadius.circular(18)),
                  clipBehavior: Clip.antiAlias,
                  child: image_url.isNotEmpty ? Image.network(image_url, fit: BoxFit.cover) : Center(),
                ),
              ),
              // 이름
              Positioned(
                left: cardWidth * 0.15,
                top: cardHeight * 0.36,
                child: SizedBox(
                  width: cardWidth * 0.7,
                  height: cardHeight * 0.09,
                  child: Center(
                    child: Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 32,
                        fontWeight: FontWeight.w700,
                        height: 0.9,
                      ),
                    ),
                  ),
                ),
              ),
              // 상세 정보
              Positioned(
                left: cardWidth * 0.13,
                top: cardHeight * 0.52,
                child: SizedBox(
                  width: cardWidth * 0.77,
                  height: cardHeight * 0.23,
                  child: Text(
                    '분류 : $category\n\n정보 : $description\n\n진로 : $careerPath',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 1.38,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
