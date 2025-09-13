import 'package:flutter/material.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final List<_Order> _orders = [
    // TODO: API 연동 시 실제 의뢰 목록 데이터로 대체 (현재 더미 데이터)
    _Order('맞춤 선반 제작', '거실용 120cm x 30cm', '대기'),
    _Order('의자 수리', '다리 흔들림 보강', '대기'),
    _Order('탁상 제작', '원목, 오일 마감', '진행중'),
  ];

  void _updateStatus(int index, String status) {
    setState(() => _orders[index] = _orders[index].copyWith(status: status));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('의뢰 상태: $status')));
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemBuilder: (context, i) {
        final o = _orders[i];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  o.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 6),
                Text(o.desc, style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _statusChip(o.status, Theme.of(context).colorScheme),
                    const Spacer(),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: Semantics(
                        button: true,
                        label: '의뢰 수락',
                        child: ElevatedButton(
                          onPressed: o.status == '대기'
                              ? () => _updateStatus(i, '진행중')
                              : null,
                          child: const Text('수락'),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Semantics(
                        button: true,
                        label: '의뢰 거절',
                        child: ElevatedButton(
                          onPressed: o.status == '대기'
                              ? () => _updateStatus(i, '거절')
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.grey.shade600,
                          ),
                          child: const Text('거절'),
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
      itemCount: _orders.length,
    );
  }

  Widget _statusChip(String status, ColorScheme cs) {
    Color bg;
    if (status == '진행중')
      bg = Colors.orange.shade100;
    else if (status == '거절')
      bg = Colors.red.shade100;
    else
      bg = Colors.blue.shade100;
    return Container(
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: Text(
        status,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    );
  }
}

class _Order {
  final String title;
  final String desc;
  final String status;
  _Order(this.title, this.desc, this.status);
  _Order copyWith({String? status}) =>
      _Order(title, desc, status ?? this.status);
}
