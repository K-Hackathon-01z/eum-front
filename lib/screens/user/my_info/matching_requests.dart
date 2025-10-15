import 'package:eum_demo/widgets/user/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/sent_note_provider.dart';

String formatDate(String date) {
  return date.split('T').first;
}

class MatchingRequests extends StatefulWidget {
  const MatchingRequests({super.key});

  @override
  State<MatchingRequests> createState() => _MatchingRequestsState();
}

class _MatchingRequestsState extends State<MatchingRequests> {
  bool _notesRequested = false;

  @override
  void initState() {
    super.initState();
    // user 정보는 기존대로 didChangeDependencies에서 처리
    // 매칭 신청 내역은 initState에서 한 번만 처리
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final authProvider = Provider.of<AuthProvider>(context, listen: false);
      final sentNoteProvider = Provider.of<SentNoteProvider>(context, listen: false);
      final int? userId = authProvider.id;
      if (userId != null && !_notesRequested) {
        _notesRequested = true;
        sentNoteProvider.fetchSentNotes(userId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final sentNoteProvider = Provider.of<SentNoteProvider>(context);

    final int? userId = authProvider.id;

    return Scaffold(
      backgroundColor: const Color(0xFFF1F1F1),
      appBar: CustomAppBar(title: '매칭 신청 내역'),
      body: authProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : userId == null
          ? const Center(child: Text('유저 정보를 불러오는 중입니다.'))
          : sentNoteProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : sentNoteProvider.notes.isEmpty
          ? const Center(child: Text('매칭 신청 내역이 없습니다.'))
          : ListView.builder(
              itemCount: sentNoteProvider.notes.length,
              itemBuilder: (context, index) {
                final note = sentNoteProvider.notes[index];
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (context) => Dialog(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(24.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '전송된 메세지',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF9785BA),
                                    ),
                                  ),
                                  const SizedBox(height: 16),
                                  Text(note.message, style: const TextStyle(fontSize: 15, color: Colors.black)),
                                  const SizedBox(height: 24),
                                  Align(
                                    alignment: Alignment.centerRight,
                                    child: Text(
                                      '전송일: ${formatDate(note.requestDate)}',
                                      style: const TextStyle(fontSize: 12, color: Colors.black54),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              right: 8,
                              top: 8,
                              child: GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Icon(Icons.close, size: 28, color: Colors.black54),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    height: 80,
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                    child: Row(
                      children: [
                        Container(
                          width: 65,
                          height: 55,
                          margin: const EdgeInsets.only(left: 17, right: 16),
                          child: const Icon(Icons.mail_outline, color: Color(0xFF9785BA), size: 50),
                        ),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'To. ${note.artisanName ?? '장인'}',
                                  style: const TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  '전송일: ${formatDate(note.requestDate)}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(Icons.chevron_right, size: 24, color: Colors.black.withOpacity(0.5)),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
