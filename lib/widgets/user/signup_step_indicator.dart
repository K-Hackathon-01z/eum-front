import 'package:flutter/material.dart';

class SignupStepIndicator extends StatelessWidget {
  final int currentStep; // 0부터 시작
  final int totalSteps;
  final List<String> stepLabels;

  const SignupStepIndicator({super.key, required this.currentStep, required this.totalSteps, required this.stepLabels});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(totalSteps, (index) {
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isActive
                      ? const Color(0xFF9785BA)
                      : isCompleted
                      ? const Color(0xFFB8A7D9)
                      : const Color(0xFFEDE7F6),
                  border: Border.all(color: isActive ? const Color(0xFF9785BA) : const Color(0xFFEDE7F6), width: 2),
                ),
                child: Center(
                  child: isCompleted
                      ? const Icon(Icons.check, size: 18, color: Colors.white)
                      : Text(
                          '${index + 1}',
                          style: TextStyle(
                            color: isActive ? Colors.white : const Color(0xFF9785BA),
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 6),
              Text(
                stepLabels[index],
                style: TextStyle(
                  fontSize: 12,
                  color: isActive ? const Color(0xFF9785BA) : const Color(0xFFB8A7D9),
                  fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
