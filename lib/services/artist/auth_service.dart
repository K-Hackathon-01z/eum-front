import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:eum_demo/models/artist/signup_request.dart';

class ArtistAuthService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  Future<bool> signup(ArtistSignupRequest req) async {
    final url = Uri.parse('$base/api/artisans');
    final res = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(req.toJson()),
    );
    return res.statusCode == 200 || res.statusCode == 201;
  }
}
