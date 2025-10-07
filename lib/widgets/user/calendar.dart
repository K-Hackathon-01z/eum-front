import 'package:flutter/material.dart';
import '../../widgets/user/button.dart';
import '../../widgets/user/popup.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_time_picker_spinner/flutter_time_picker_spinner.dart';

class CalendarWidget extends StatefulWidget {
  final void Function(DateTime? date)? onSelected;
  const CalendarWidget({super.key, this.onSelected});

  @override
  State<CalendarWidget> createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  DateTime focusedDay = DateTime.now();
  DateTime? selectedDay;
  DateTime? selectedTime;
  bool _dialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_dialogShown) {
      _dialogShown = true;
      Future.microtask(_showCalendarDialog);
    }
  }

  Future<void> _showCalendarDialog() async {
    final result = await showDialog<DateTime>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              insetPadding: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  width: 350,
                  height: 460,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 365)),
                        focusedDay: focusedDay,
                        selectedDayPredicate: (day) =>
                            selectedDay != null &&
                            day.year == selectedDay!.year &&
                            day.month == selectedDay!.month &&
                            day.day == selectedDay!.day,
                        onDaySelected: (day, focus) {
                          setState(() {
                            selectedDay = day;
                            focusedDay = focus;
                          });
                        },
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: const Color(0xFF9785BA).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(color: const Color(0xFF9785BA), shape: BoxShape.circle),
                          selectedTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                          todayTextStyle: const TextStyle(color: Color(0xFF9785BA), fontWeight: FontWeight.bold),
                        ),
                        headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
                      ),
                      Spacer(),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: selectedDay != null ? const Color(0xFF9785BA) : Colors.grey.shade300,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: selectedDay != null
                                  ? () async {
                                      // 시간 선택 모달 오픈
                                      DateTime pickedTime = DateTime.now();
                                      final selectedDateTime = await showDialog<DateTime>(
                                        context: context,
                                        barrierDismissible: false,
                                        builder: (context) {
                                          return StatefulBuilder(
                                            builder: (context, setState) {
                                              return Dialog(
                                                backgroundColor: Colors.white,
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                                                insetPadding: const EdgeInsets.all(16),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(16.0),
                                                  child: SizedBox(
                                                    width: 320,
                                                    height: 260,
                                                    child: Column(
                                                      mainAxisSize: MainAxisSize.max,
                                                      children: [
                                                        const Text(
                                                          '시간 선택',
                                                          style: TextStyle(
                                                            fontWeight: FontWeight.bold,
                                                            fontSize: 16,
                                                            color: Color(0xFF9785BA),
                                                          ),
                                                        ),
                                                        const SizedBox(height: 8),
                                                        TimePickerSpinner(
                                                          is24HourMode: false,
                                                          normalTextStyle: const TextStyle(
                                                            fontSize: 16,
                                                            color: Colors.black54,
                                                          ),
                                                          highlightedTextStyle: const TextStyle(
                                                            fontSize: 18,
                                                            color: Color(0xFF9785BA),
                                                          ),
                                                          spacing: 30,
                                                          itemHeight: 30,
                                                          isShowSeconds: false,
                                                          onTimeChange: (time) {
                                                            setState(() {
                                                              pickedTime = time;
                                                            });
                                                          },
                                                        ),
                                                        const Spacer(),
                                                        Row(
                                                          children: [
                                                            Expanded(
                                                              child: ElevatedButton(
                                                                style: ElevatedButton.styleFrom(
                                                                  backgroundColor: const Color(0xFF9785BA),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                ),
                                                                onPressed: () {
                                                                  final resultDateTime = DateTime(
                                                                    selectedDay!.year,
                                                                    selectedDay!.month,
                                                                    selectedDay!.day,
                                                                    pickedTime.hour,
                                                                    pickedTime.minute,
                                                                  );
                                                                  Navigator.of(context).pop(resultDateTime);
                                                                },
                                                                child: const Text(
                                                                  '확인',
                                                                  style: TextStyle(color: Colors.white),
                                                                ),
                                                              ),
                                                            ),
                                                            const SizedBox(width: 16),
                                                            Expanded(
                                                              child: OutlinedButton(
                                                                style: OutlinedButton.styleFrom(
                                                                  side: const BorderSide(color: Color(0xFF9785BA)),
                                                                  shape: RoundedRectangleBorder(
                                                                    borderRadius: BorderRadius.circular(8),
                                                                  ),
                                                                ),
                                                                onPressed: () => Navigator.of(context).pop(),
                                                                child: const Text(
                                                                  '닫기',
                                                                  style: TextStyle(color: Color(0xFF9785BA)),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                      );
                                      if (selectedDateTime != null) {
                                        Navigator.of(context).pop(selectedDateTime);
                                      }
                                    }
                                  : null,
                              child: const Text('확인', style: TextStyle(color: Colors.white)),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Color(0xFF9785BA)),
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                              ),
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('닫기', style: TextStyle(color: Color(0xFF9785BA))),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
    if (!mounted) return;
    if (result == null) {
      Navigator.of(context).pop();
      return;
    }
    await _showConfirmDialog(result);
  }

  Future<void> _showConfirmDialog(DateTime date) async {
    final result = await showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final dateStr = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
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
      widget.onSelected?.call(date);
      // 예약 성공 팝업 표시
      showDialog(
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
                navigator.pushNamedAndRemoveUntil('/home', (route) => false, arguments: {'tab': 3});
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
