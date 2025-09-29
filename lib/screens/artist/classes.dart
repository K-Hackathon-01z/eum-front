import 'package:eum_demo/services/artist/class_schedule.dart';
import 'package:flutter/material.dart';


class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final List<_ClassItem> _classes = [
    // TODO: API 연동 시 실제 클래스 목록 데이터로 대체 (현재 더미 데이터)
    _ClassItem('목공 기초 — 선반 만들기',DateTime.now().add(const Duration(days: 2)),6,2,),
    _ClassItem('도마 만들기', DateTime.now().add(const Duration(days: 7)), 8, 5),
  ];

  final _service = ClassScheduleService();

  Future<void> _addClassDialog() async {
    final titleCtl = TextEditingController();
    final classIdCtl = TextEditingController(text: '1');
    DateTime? date;
    TimeOfDay? time;
    int capacity = 6;

    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('클래스 추가'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: titleCtl,
                  decoration: const InputDecoration(
                    labelText: '제목',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: classIdCtl,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    labelText: '클래스 ID',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final now = DateTime.now();
                          final picked = await showDatePicker(
                            context: context,
                            initialDate: now.add(const Duration(days: 1)),
                            firstDate: now,
                            lastDate: now.add(const Duration(days: 365)),
                          );
                          if (picked != null) {
                            date = picked;
                            // ignore: use_build_context_synchronously
                            (context as Element).markNeedsBuild();
                          }
                        },
                        child: Text(
                          date == null
                              ? '날짜 선택'
                              : '${date!.year}-${date!.month}-${date!.day}',
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () async {
                          final picked = await showTimePicker(
                            context: context,
                            initialTime: const TimeOfDay(hour: 14, minute: 0),
                          );
                          if (picked != null) {
                            time = picked;
                            // ignore: use_build_context_synchronously
                            (context as Element).markNeedsBuild();
                          }
                        },
                        child: Text(
                          time == null
                              ? '시간 선택'
                              : '${time!.hour.toString().padLeft(2, '0')}:${time!.minute.toString().padLeft(2, '0')}',
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<int>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: '정원',
                        ),
                        value: capacity,
                        items: [4, 6, 8, 10, 12]
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text('$e명'),
                              ),
                            )
                            .toList(),
                        onChanged: (v) => capacity = v ?? capacity,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('취소'),
            ),
            ElevatedButton(
              onPressed: () async {
                final title = titleCtl.text.trim();
                final cid = int.tryParse(classIdCtl.text.trim());
                if (title.isEmpty ||
                    date == null ||
                    time == null ||
                    cid == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('제목/클래스ID/날짜/시간을 확인하세요.')),
                  );
                  return;
                }
                try {
                  final res = await _service.createSchedule(
                    classId: cid,
                    date: date!,
                    time: time!,
                    capacity: capacity,
                    currentCount: 0,
                  );
                  if (!mounted) return;
                  setState(() {
                    final dt = DateTime(
                      date!.year,
                      date!.month,
                      date!.day,
                      time!.hour,
                      time!.minute,
                    );
                    final enrolled = (res['currentCount'] as int?) ?? 0;
                    _classes.add(_ClassItem(title, dt, capacity, enrolled));
                  });
                  Navigator.pop(context);
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(const SnackBar(content: Text('클래스를 추가했습니다.')));
                } catch (e) {
                  if (!mounted) return;
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('추가 실패: $e')));
                }
              },
              child: const Text('추가'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemBuilder: (context, i) {
          final c = _classes[i];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    c.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    '일정: ${c.date.year}-${c.date.month}-${c.date.day}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    '정원: ${c.capacity}명 / 신청: ${c.enrolled}명',
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  // 진행률 표시 (접근성 텍스트 포함)
                  Semantics(
                    label: '수강 신청 진행률',
                    child: LinearProgressIndicator(
                      value: (c.enrolled / c.capacity).clamp(0, 1).toDouble(),
                      minHeight: 8,
                      backgroundColor: Colors.grey.shade200,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: Semantics(
                          button: true,
                          label: '출석부 보기',
                          child: ElevatedButton(
                            onPressed: () {
                              // 출석부 보기 기능 구현 필요
                            },
                            child: const Text('출석부 보기'),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Semantics(
                          button: true,
                          label: '클래스 삭제',
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() => _classes.removeAt(i));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('클래스를 삭제했습니다.')),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              //backgroundColor: Colors.deepPurpleAccent,
                            ),
                            child: const Text('삭제'),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 10),
        itemCount: _classes.length,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _addClassDialog,
        icon: const Icon(Icons.add),
        label: const Text('클래스 추가'),
      ),
    );
  }
}

class _ClassItem {
  final String title;
  final DateTime date;
  final int capacity;
  final int enrolled;
  _ClassItem(this.title, this.date, this.capacity, this.enrolled);
}
