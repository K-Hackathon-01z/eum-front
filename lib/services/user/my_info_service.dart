// api.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyInfoService {
  static final String base = dotenv.env['API_BASE_URL'] ?? '';
}
