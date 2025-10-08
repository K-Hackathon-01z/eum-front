class MatchingRequest {
  final int id;
  final bool isAnonymous;
  final String message;
  final DateTime requestAt;
  final bool read;
  final DateTime? readAt;
  final String senderName;
  final String senderEmail;
  final int? senderAge;

  MatchingRequest({
    required this.id,
    required this.isAnonymous,
    required this.message,
    required this.requestAt,
    required this.read,
    this.readAt,
    required this.senderName,
    required this.senderEmail,
    this.senderAge,
  });

  factory MatchingRequest.fromJson(Map<String, dynamic> json) {
    DateTime? _parse(String? v) => v == null ? null : DateTime.tryParse(v);
    return MatchingRequest(
      id: json['id'] is int ? json['id'] : int.tryParse('${json['id']}') ?? 0,
      isAnonymous: json['isAnonymous'] == true,
      message: '${json['message'] ?? ''}',
      // 스웨거 예: requestDate, 백엔드에 따라 키 유연 처리
      requestAt:
          _parse(
            json['requestAt']?.toString() ?? json['requestDate']?.toString(),
          ) ??
          DateTime.now(),
      read: json['read'] == true,
      readAt: _parse(json['readAt']?.toString()),
      senderName: '${json['senderName'] ?? ''}',
      senderEmail: '${json['senderEmail'] ?? ''}',
      senderAge: json['senderAge'] is int
          ? json['senderAge']
          : int.tryParse('${json['senderAge']}'),
    );
  }
}
