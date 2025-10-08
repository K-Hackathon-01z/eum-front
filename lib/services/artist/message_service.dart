import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eum_demo/models/artist/matching_request.dart';

class MatchingRequestService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<MatchingRequest>> fetchByArtisanId(
    int artisanId, {
    bool unreadOnly = false,
  }) async {
    final uri = Uri.parse(
      '$base/api/matching-requests/artisan/$artisanId',
    ).replace(queryParameters: {'unreadOnly': unreadOnly.toString()});
    final res = await http.get(uri, headers: {'accept': '*/*'});
    if (res.statusCode == 200) {
      final data = jsonDecode(res.body);
      if (data is List) {
        return data
            .map((e) => MatchingRequest.fromJson(e as Map<String, dynamic>))
            .toList();
      }
      return [];
    }
    throw Exception('쪽지 목록 조회 실패: ${res.statusCode} / ${res.body}');
  }
}
