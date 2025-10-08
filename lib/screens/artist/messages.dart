import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eum_demo/providers/artist_provider.dart';
import 'package:eum_demo/providers/artist_matching_request_provider.dart';
import 'package:eum_demo/models/artist/matching_request.dart';

class MessagesPage extends StatefulWidget {
  const MessagesPage({super.key});

  @override
  State<MessagesPage> createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  bool _inited = false;
  bool _unreadOnly = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_inited) {
      final artistId = context.read<ArtistProvider>().current?.id;
      if (artistId != null) {
        context.read<MatchingRequestProvider>().fetch(
          artistId,
          unreadOnly: _unreadOnly,
        );
      }
      _inited = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MatchingRequestProvider>();

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (provider.error != null) {
      return Center(child: Text('에러: ${provider.error}'));
    }
    final items = provider.items;
    if (items.isEmpty) {
      return const Center(child: Text('받은 쪽지가 없습니다.'));
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
          child: Row(
            children: [
              FilterChip(
                label: const Text('읽지 않은 쪽지'),
                selected: _unreadOnly,
                onSelected: (v) {
                  setState(() => _unreadOnly = v);
                  final artistId = context.read<ArtistProvider>().current?.id;
                  if (artistId != null) {
                    context.read<MatchingRequestProvider>().fetch(
                      artistId,
                      unreadOnly: _unreadOnly,
                    );
                  }
                },
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemCount: items.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, i) {
              final t = items[i];
              return ListTile(
                leading: CircleAvatar(child: Text(_avatarText(t))),
                title: Text(
                  t.senderName.isNotEmpty
                      ? t.senderName
                      : (t.isAnonymous ? '익명' : '이름 없음'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                subtitle: Text(
                  t.message,
                  style: const TextStyle(fontSize: 16),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _fmtTime(t.requestAt),
                      style: const TextStyle(fontSize: 12),
                    ),
                    const SizedBox(height: 4),
                    if (!t.read)
                      const Icon(
                        Icons.brightness_1,
                        color: Colors.redAccent,
                        size: 10,
                      ),
                  ],
                ),
                onTap: () => _openThread(context, t),
              );
            },
          ),
        ),
      ],
    );
  }

  String _avatarText(MatchingRequest t) {
    final name = t.senderName;
    return name.isNotEmpty
        ? name.characters.first
        : (t.isAnonymous ? '익' : '?');
  }

  String _fmtTime(DateTime dt) {
    final now = DateTime.now();
    final isToday =
        now.year == dt.year && now.month == dt.month && now.day == dt.day;
    if (isToday) {
      final h = dt.hour.toString().padLeft(2, '0');
      final m = dt.minute.toString().padLeft(2, '0');
      return '$h:$m';
    }
    final mm = dt.month.toString().padLeft(2, '0');
    final dd = dt.day.toString().padLeft(2, '0');
    return '${dt.year}-$mm-$dd';
  }

  void _openThread(BuildContext context, MatchingRequest t) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          '${t.senderName.isEmpty ? (t.isAnonymous ? "익명" : "이름 없음") : t.senderName} 님의 쪽지',
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(t.message),
            const SizedBox(height: 12),
            Text(
              '이메일: ${t.senderEmail.isEmpty ? '-' : t.senderEmail}',
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              '나이: ${t.senderAge ?? '-'}',
              style: const TextStyle(color: Colors.grey),
            ),
            Text(
              '작성일: ${_fmtTime(t.requestAt)}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
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
