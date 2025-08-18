import 'package:flutter/material.dart';

class CareerTestResultPage extends StatelessWidget {
  final List<dynamic> resultList;
  const CareerTestResultPage({Key? key, required this.resultList})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Align(
          alignment: Alignment.center,
          child: Text('나에게 추천된 기술'),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '이런 기술들이 잘 맞아요!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color(0xFF222B45),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              '아래 추천 기술을 기반으로 커리어를 설계해보세요.',
              style: TextStyle(fontSize: 15, color: Color(0xFF6B7684)),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 1.15,
                ),
                itemCount: resultList.length,
                itemBuilder: (context, index) {
                  final skill = resultList[index];
                  return _SkillCard(
                    name: skill['skillName'] ?? '',
                    score: skill['totalScore']?.toString() ?? '',
                    index: index,
                    onTap: () {
                      // 장인 매칭 페이지로 보여주는 동작을 해야함
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

class _SkillCard extends StatelessWidget {
  final String name;
  final String score;
  final int index;
  final VoidCallback onTap;

  const _SkillCard({
    required this.name,
    required this.score,
    required this.index,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = [
      Color(0xFFEEF7FF),
      Color(0xFFFFF3E6),
      Color(0xFFF3F6F9),
      Color(0xFFFFF0F6),
      Color(0xFFE6F7F1),
    ];
    final cardColor = colors[index % colors.length];
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(Icons.star_rounded, color: Color(0xFF4F8CFF), size: 28),
                  SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF222B45),
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text(
                '점수: $score',
                style: TextStyle(fontSize: 14, color: Color(0xFF6B7684)),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
