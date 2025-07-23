import 'package:flutter/material.dart';

class OnedayClassCard extends StatelessWidget {
  final String region;
  final String desc;
  final String price;
  final Widget? image;

  const OnedayClassCard({super.key, required this.region, required this.desc, required this.price, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 300,
      decoration: BoxDecoration(color: const Color(0xFFF5F5F5), borderRadius: BorderRadius.circular(24)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: double.infinity,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final double size = constraints.maxWidth;
                  return image ??
                      Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          color: const Color(0xFFD9D9D9),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          'Photo',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                        ),
                      );
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  region,
                  style: const TextStyle(fontSize: 13, color: Colors.black54, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 3),
                Text(desc, style: const TextStyle(fontSize: 13, color: Colors.black, height: 1.3)),
                const SizedBox(height: 8),
                Text(
                  price,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
