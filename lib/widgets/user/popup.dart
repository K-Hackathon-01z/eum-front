import 'package:flutter/material.dart';

/// 공용 팝업 위젯: 성공/실패/안내 등 다양한 상황에서 사용 가능
/// [icon], [title], [message], [buttonText], [onPressed]를 파라미터로 받아 커스텀 가능
class CommonPopup extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String message;
  final String button1Text;
  final VoidCallback? onButtonFirstPressed;
  final Color? button1Color;
  final String? button2Text;
  final VoidCallback? onButtonSecondPressed;
  final Color? button2Color;
  final VoidCallback? onClose;
  final bool showCloseIcon;

  const CommonPopup({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xFFC7B5EB),
    required this.title,
    required this.message,
    this.button1Text = '확인',
    this.onButtonFirstPressed,
    this.button1Color,
    this.button2Text,
    this.onButtonSecondPressed,
    this.button2Color,
    this.onClose,
    this.showCloseIcon = true,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(icon, size: 56, color: iconColor),
                const SizedBox(height: 16),
                Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Text(message, style: const TextStyle(fontSize: 16), textAlign: TextAlign.center),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: button1Color ?? iconColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    onPressed: onButtonFirstPressed,
                    child: Text(button1Text, style: const TextStyle(fontSize: 16, color: Colors.white)),
                  ),
                ),
                if (button2Text != null) ...[
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: button2Color ?? Colors.white,
                        foregroundColor: button2Color != null ? Colors.white : iconColor,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        side: BorderSide(color: button2Color ?? iconColor),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      onPressed: onButtonSecondPressed,
                      child: Text(
                        button2Text!,
                        style: TextStyle(fontSize: 16, color: button2Color != null ? Colors.white : iconColor),
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
          if (showCloseIcon)
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: onClose,
                child: const Icon(Icons.close, size: 28, color: Colors.black38),
              ),
            ),
        ],
      ),
    );
  }
}
