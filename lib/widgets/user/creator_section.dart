import 'package:flutter/material.dart';

class CreatorSection extends StatelessWidget {
  final IconData icon;
  final String title;
  final String content;
  final Color color;

  const CreatorSection({
    required this.icon,
    required this.title,
    required this.content,
    required this.color,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: color),
            SizedBox(width: 8),
            Text(
              title,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: color),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(content, style: TextStyle(fontSize: 16)),
        ),
        SizedBox(height: 16),
      ],
    );
  }
}
