class SentNote {
  final int id;
  final bool isAnonymous;
  final String message;
  final String requestDate;
  final bool read;
  final String? readAt;
  final String? senderName;
  final String? senderEmail;
  final int? senderAge;

  SentNote({
    required this.id,
    required this.isAnonymous,
    required this.message,
    required this.requestDate,
    this.read = false,
    this.readAt,
    this.senderName,
    this.senderEmail,
    this.senderAge,
  });

  factory SentNote.fromJson(Map<String, dynamic> json) {
    return SentNote(
      id: json['id'],
      isAnonymous: json['isAnonymous'],
      message: json['message'],
      requestDate: json['requestDate'],
      read: json['read'],
      readAt: json['readAt'],
      senderName: json['senderName'],
      senderEmail: json['senderEmail'],
      senderAge: json['senderAge'],
    );
  }
}
