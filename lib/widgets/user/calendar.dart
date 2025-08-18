import 'package:flutter/material.dart';
import '../../widgets/user/button.dart';
import '../../widgets/user/popup.dart';

/// Flutter 기본 제공 날짜/시간 선택 다이얼로그를 띄우는 위젯
class CalendarWidget extends StatefulWidget {
  final void Function(DateTime? date, TimeOfDay? time)? onSelected;
  const CalendarWidget({super.key, this.onSelected});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  bool _dialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dialogShown) {
      _dialogShown = true;
      Future.microtask(_pickDateTime);
    }
  }

  Future<void> _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (!mounted) return;
    if (date == null) {
      Navigator.of(context).pop();
      return;
    }
    // Material input 방식 시간 선택
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      initialEntryMode: TimePickerEntryMode.input,
    );
    if (!mounted) return;
    if (time == null) {
      Navigator.of(context).pop();
      return;
    }
    // 30분 단위로 반올림
    final roundedMinute = (time.minute < 15) ? 0 : (time.minute < 45 ? 30 : 0);
    final roundedHour = (time.minute < 45) ? time.hour : (time.hour + 1) % 24;
    final roundedTime = TimeOfDay(hour: roundedHour, minute: roundedMinute);
    await _showConfirmDialog(date, roundedTime);
  }

  Future<void> _showConfirmDialog(DateTime date, TimeOfDay time) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
        final timeStr = time.format(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          title: const Text('예약 정보 확인', style: TextStyle(fontWeight: FontWeight.bold)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 20, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Text(dateStr, style: const TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(Icons.access_time, size: 20, color: Colors.deepPurple),
                  const SizedBox(width: 8),
                  Text(timeStr, style: const TextStyle(fontSize: 16)),
                ],
              ),
            ],
          ),
          actionsPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 8),
          actions: [
            Row(
              children: [
                Expanded(
                  child: Button(
                    text: '예',
                    textColor: Colors.white,
                    backgroundColor: const Color(0xFF9785BA),
                    onPressed: () => Navigator.of(context).pop(true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Button(
                    text: '아니오',
                    textColor: const Color(0xFF9785BA),
                    backgroundColor: Colors.white,
                    borderColor: const Color(0xFF9785BA),
                    onPressed: () => Navigator.of(context).pop(false),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
    if (!mounted) return;
    if (result == true) {
      widget.onSelected?.call(date, time);
      // 예약 성공 팝업 표시
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) {
          final navigator = Navigator.of(context);
          return CommonPopup(
            icon: Icons.check_circle,
            iconColor: const Color(0xFF9785BA),
            title: '예약이 성공하였습니다!',
            message: '예약 내역은 마이페이지에서 확인할 수 있습니다.',
            button1Text: '홈 바로가기',
            onButtonFirstPressed: () {
              navigator.pop(); // 팝업 닫기
              navigator.pop(); // calendar 닫기
              Future.microtask(() {
                navigator.pushNamedAndRemoveUntil('/home', (route) => false);
              });
            },
            button2Text: '마이페이지 바로가기',
            onButtonSecondPressed: () {
              navigator.pop(); // 팝업 닫기
              navigator.pop(); // calendar 닫기
              Future.microtask(() {
                navigator.pushNamedAndRemoveUntil('/my-info', (route) => false);
              });
            },
          );
        },
      );
    } else {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // 바로 다이얼로그가 뜨므로, 위젯 자체는 빈 컨테이너만 반환
    return const SizedBox.shrink();
  }
}
