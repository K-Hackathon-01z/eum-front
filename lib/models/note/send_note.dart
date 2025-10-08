class SendNote {
  final int userId;
  final int artisanId;
  final String message;
  final bool isAnonymous;

  SendNote({required this.userId, required this.artisanId, required this.message, required this.isAnonymous});

  Map<String, dynamic> toJson() {
    return {'userId': userId, 'artisanId': artisanId, 'message': message, 'isAnonymous': isAnonymous};
  }
}
