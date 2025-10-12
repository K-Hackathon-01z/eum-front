import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../models/oneday_class/class.dart';

class ClassService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';

  /// 모든 원데이 클래스 정보를 가져옵니다.
  static Future<List<OnedayClass>> fetchAllClasses() async {
    final response = await http.get(Uri.parse('$base/classes/all'));
    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((e) => OnedayClass.fromJson(e)).toList();
    } else {
      throw Exception('클래스 정보를 불러오지 못했습니다: ${response.statusCode}');
    }
  }
}
