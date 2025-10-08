import 'package:flutter/material.dart';
import 'package:eum_demo/services/artist/class_service.dart';
import 'package:eum_demo/models/artist/class_request.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

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

  final _classService = ClassService(); // 추가

  Future<void> _addClassDialog() async {
    final titleCtl = TextEditingController();
    final photoUrlCtl = TextEditingController(text: 'string');
    final descCtl = TextEditingController();
    final priceCtl = TextEditingController();
    final locationCtl = TextEditingController();

    DateTime? date;
    int capacity = 6;
    File? pickedImage;
    bool uploading = false;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setLocal) {
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
                    const SizedBox(height: 12),

                    // 이미지 선택/업로드
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.photo_library),
                            label: const Text('사진 선택'),
                            onPressed: () async {
                              final x = await ImagePicker().pickImage(
                                source: ImageSource.gallery,
                                maxWidth: 2000,
                              );
                              if (x != null) {
                                pickedImage = File(x.path);
                                setLocal(() {});
                              }
                            },
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: OutlinedButton.icon(
                            icon: uploading
                                ? const SizedBox(
                                    width: 16,
                                    height: 16,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Icon(Icons.cloud_upload),
                            label: Text(uploading ? '업로드 중...' : '업로드'),
                            onPressed: (pickedImage == null || uploading)
                                ? null
                                : () async {
                                    try {
                                      setLocal(() => uploading = true);
                                      final url = await _classService
                                          .uploadClassImage(pickedImage!);
                                      photoUrlCtl.text = url; // 응답 URL 자동 채움
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('이미지 업로드 완료'),
                                          ),
                                        );
                                      }
                                    } catch (e) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(content: Text('업로드 실패: $e')),
                                        );
                                      }
                                    } finally {
                                      setLocal(() => uploading = false);
                                    }
                                  },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    if (pickedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          pickedImage!,
                          height: 140,
                          fit: BoxFit.cover,
                        ),
                      ),

                    const SizedBox(height: 12),
                    TextField(
                      controller: priceCtl,
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                        labelText: '가격(정수, 원)',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: locationCtl,
                      decoration: const InputDecoration(
                        labelText: '장소',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextField(
                      controller: descCtl,
                      maxLines: 3,
                      decoration: const InputDecoration(
                        labelText: '설명',
                        border: OutlineInputBorder(),
                      ),
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
                    if (titleCtl.text.trim().isEmpty || date == null) return;
                    final price = int.tryParse(priceCtl.text.trim());
                    if (price == null || price <= 0) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('가격을 올바르게 입력하세요.')),
                      );
                      return;
                    }
                    final req = ArtistClassRequest(
                      skillId: 1,
                      artisanId: 1,
                      title: titleCtl.text.trim(),
                      photoUrl: photoUrlCtl.text.trim().isEmpty
                          ? 'string'
                          : photoUrlCtl.text.trim(),
                      description: descCtl.text.trim(),
                      price: price,
                      location: locationCtl.text.trim(),
                      capacity: capacity,
                    );
                    try {
                      await _classService.createClass(req);
                      if (!mounted) return;
                      setState(
                        () => _classes.add(
                          _ClassItem(req.title, date!, req.capacity, 0),
                        ),
                      );
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('클래스를 등록했습니다.')),
                      );
                    } catch (e) {
                      if (!mounted) return;
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text('등록 실패: $e')));
                    }
                  },
                  child: const Text('추가'),
                ),
              ],
            );
          },
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
