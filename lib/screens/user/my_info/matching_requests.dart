import 'package:eum_demo/widgets/user/appbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_provider.dart';
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
  bool _userRequested = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final String email = authProvider.email ?? '';
    if (!_userRequested && authProvider.email == null && !authProvider.isLoading && email.isNotEmpty) {
      _userRequested = true;
      Future.microtask(() => userProvider.fetchUserByEmail(email));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final sentNoteProvider = Provider.of<SentNoteProvider>(context);

    final int? userId = authProvider.id;
    if (userId != null && sentNoteProvider.notes.isEmpty && !sentNoteProvider.isLoading) {
      sentNoteProvider.fetchSentNotes(userId);
    }

    return Scaffold(
      backgroundColor: Colors.white,
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
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(title: Text(note.message), subtitle: Text('신청일: ${formatDate(note.requestDate)}')),
                );
              },
            ),
    );
  }
}
