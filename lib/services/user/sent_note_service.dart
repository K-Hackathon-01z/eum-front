import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/note/sent_note.dart';

class SentNoteService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<SentNote>> fetchSentNotes(int userId) async {
    final response = await http.get(Uri.parse('$baseUrl/api/matching-requests/user/$userId'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => SentNote.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load sent notes');
    }
  }
}
