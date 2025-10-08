import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/note/send_note.dart';

class SendNoteService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<bool> sendNote(SendNote request) async {
    final response = await http.post(
      Uri.parse('$baseUrl/api/matching-requests'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(request.toJson()),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to send note');
    }
  }
}
