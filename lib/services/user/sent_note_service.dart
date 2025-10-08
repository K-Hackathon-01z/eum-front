import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/user/sent_note.dart';

class SentNoteService {
  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<SentNote>> fetchSentNotes(int userId) async {
    // 임시 하드코딩
    final response = await http.get(Uri.parse('$baseUrl/api/matching-requests/user/1'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => SentNote.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load sent notes');
    }
  }
}
