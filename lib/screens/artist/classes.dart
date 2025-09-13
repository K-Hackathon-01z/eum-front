import 'package:flutter/material.dart';

class ClassesPage extends StatefulWidget {
  const ClassesPage({super.key});

  @override
  State<ClassesPage> createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  final List<_ClassItem> _classes = [
    // TODO: API 연동 시 실제 클래스 목록 데이터로 대체 (현재 더미 데이터)
    _ClassItem(
      '목공 기초 — 선반 만들기',
      DateTime.now().add(const Duration(days: 2)),
      6,
      2,
    ),
    _ClassItem('도마 만들기', DateTime.now().add(const Duration(days: 7)), 8, 5),
  ];

  Future<void> _addClassDialog() async {
    final titleCtl = TextEditingController();
    DateTime? date;
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
              onPressed: () {
                if (titleCtl.text.trim().isEmpty || date == null) return;
                setState(() {
                  _classes.add(
                    _ClassItem(titleCtl.text.trim(), date!, capacity, 0),
                  );
                });
                Navigator.pop(context);
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
                            onPressed: () {},
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
                              backgroundColor: Colors.grey.shade700,
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
