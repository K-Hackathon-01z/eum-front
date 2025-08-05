import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final Color backgroundColor;
  final Color textColor;
  final Color? borderColor;

  const Button({
    super.key,
    this.text = '텍스트',
    this.onPressed,
    this.width = 220,
    this.height = 48,
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor,
          elevation: 10,
          shadowColor: Colors.black.withOpacity(0.25),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
            side: borderColor == null ? BorderSide.none : BorderSide(color: borderColor!, width: 1),
          ),
          textStyle: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
        ),
        child: Text(
          text,
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: textColor),
        ),
      ),
    );
  }
}
