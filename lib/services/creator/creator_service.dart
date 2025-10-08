import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/creator/creator.dart';

class CreatorService {
  Future<Creator?> fetchCreatorByEmail(String email) async {
    final response = await http.get(Uri.parse('$baseUrl/api/artisans/email/$email'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data == null) return null;
      return Creator.fromJson(data);
    } else {
      throw Exception('Failed to load creator by email');
    }
  }

  final String baseUrl = dotenv.env['API_BASE_URL'] ?? '';

  Future<List<Creator>> fetchAllCreators() async {
    final response = await http.get(Uri.parse('$baseUrl/api/artisans/all'));
    if (response.statusCode == 200) {
      final List data = json.decode(response.body);
      return data.map((e) => Creator.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load creators');
    }
  }
}
