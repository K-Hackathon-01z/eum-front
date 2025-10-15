import 'package:flutter/material.dart';

class OnedayClassCard extends StatelessWidget {
  final String title;
  final String region;
  final String desc;
  final String price;
  final String? imagePath;

  const OnedayClassCard({
    super.key,
    required this.title,
    required this.region,
    required this.desc,
    required this.price,
    this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1.2),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.07), blurRadius: 10, offset: const Offset(0, 4))],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 180,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double size = constraints.maxWidth;
                  if (imagePath != null && imagePath!.isNotEmpty) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.asset(imagePath!, width: size, height: size, fit: BoxFit.cover),
                    );
                  } else {
                    return Container(
                      width: size,
                      height: size,
                      decoration: BoxDecoration(
                        color: const Color(0xFFD9D9D9),
                        borderRadius: BorderRadius.circular(18),
                      ),
                      alignment: Alignment.center,
                    );
                  }
                },
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    region,
                    style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 10),
                  Text(desc, style: const TextStyle(fontSize: 13, color: Colors.black, height: 1.3)),
                  const SizedBox(height: 10),
                  Text(
                    price,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
