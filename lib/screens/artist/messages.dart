import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  MessagesPage({super.key});

  // TODO: API 연동 시 실제 메시지 스레드 목록으로 대체 (현재 더미 데이터)
  final List<_Thread> _threads = [
    _Thread('고객A', '선반 제작 문의드립니다.', '어제'),
    _Thread('고객B', '클래스 신청 관련 질문이 있어요.', '2일 전'),
    _Thread('고객C', '견적 부탁드립니다.', '1주 전'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, i) {
        final t = _threads[i];
        return ListTile(
          leading: CircleAvatar(child: Text(t.name.characters.first)),
          title: Text(
            t.name,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800),
          ),
          subtitle: Text(t.lastMessage, style: const TextStyle(fontSize: 16)),
          trailing: Text(t.time, style: const TextStyle(fontSize: 14)),
          onTap: () => _openThread(context, t),
        );
      },
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemCount: _threads.length,
    );
  }

  void _openThread(BuildContext context, _Thread t) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('${t.name} 님과의 대화'),
        content: const Text('API 연동 시 실제 메시지 목록이 표시됩니다.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('닫기'),
          ),
        ],
      ),
    );
  }
}

class _Thread {
  final String name;
  final String lastMessage;
  final String time;
  _Thread(this.name, this.lastMessage, this.time);
}
