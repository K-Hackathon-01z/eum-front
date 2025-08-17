import 'package:flutter/material.dart';

class CareerTestResultPage extends StatelessWidget {
  const CareerTestResultPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: 실제 API 데이터로 대체
    final List<Map<String, String>> recommendedSkills = [
      {'name': 'Flutter', 'desc': '크로스플랫폼 앱 개발 프레임워크'},
      {'name': 'React', 'desc': '프론트엔드 UI 라이브러리'},
      {'name': 'Python', 'desc': '다목적 프로그래밍 언어'},
      {'name': 'Dart', 'desc': 'Flutter의 언어, 빠른 개발'},
      {'name': 'Node.js', 'desc': '백엔드 자바스크립트 런타임'},
      {'name': 'AWS', 'desc': '클라우드 서비스'},
      {'name': 'Figma', 'desc': 'UI/UX 디자인 툴'},
      {'name': 'Kotlin', 'desc': '안드로이드 공식 언어'},
      {'name': 'Swift', 'desc': 'iOS 공식 언어'},
      {'name': 'TensorFlow', 'desc': '머신러닝 프레임워크'},
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text('나에게 추천된 기술'),
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
                itemCount: recommendedSkills.length,
                itemBuilder: (context, index) {
                  final skill = recommendedSkills[index];
                  return _SkillCard(
                    name: skill['name']!,
                    desc: skill['desc']!,
                    index: index,
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

class _SkillCard extends StatefulWidget {
  final String name;
  final String desc;
  final int index;

  const _SkillCard({
    required this.name,
    required this.desc,
    required this.index,
    Key? key,
  }) : super(key: key);

  @override
  State<_SkillCard> createState() => _SkillCardState();
}

class _SkillCardState extends State<_SkillCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500 + widget.index * 60),
    );
    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutCubic,
    );
    Future.delayed(Duration(milliseconds: 80 * widget.index), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = [
      Color(0xFFEEF7FF),
      Color(0xFFFFF3E6),
      Color(0xFFF3F6F9),
      Color(0xFFFFF0F6),
      Color(0xFFE6F7F1),
    ];
    final cardColor = colors[widget.index % colors.length];
    return FadeTransition(
      opacity: _fadeAnim,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOutCubic,
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(18),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.star_rounded,
                      color: Color(0xFF4F8CFF),
                      size: 28,
                    ),
                    SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        widget.name,
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
                  widget.desc,
                  style: TextStyle(fontSize: 14, color: Color(0xFF6B7684)),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
