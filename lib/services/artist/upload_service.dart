import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UploadService {
  final String _uploadUrl = dotenv.env['CLOUDINARY_UPLOAD_URL'] ?? '';
  final String _preset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? '';

  Future<String> uploadImage(File file) async {
    if (_uploadUrl.isEmpty) {
      throw Exception('업로드 URL(Cloudinary)이 설정되지 않았습니다.');
    }
    final req = http.MultipartRequest('POST', Uri.parse(_uploadUrl));
    req.files.add(await http.MultipartFile.fromPath('file', file.path));
    if (_preset.isNotEmpty) req.fields['upload_preset'] = _preset;

    final res = await req.send();
    final body = await res.stream.bytesToString();

    if (res.statusCode == 200 || res.statusCode == 201) {
      final data = jsonDecode(body);
      final url = (data['secure_url'] ?? data['url'] ?? '').toString();
      if (url.isEmpty) throw Exception('응답에 URL이 없습니다.');
      return url;
    }
    throw Exception('업로드 실패(${res.statusCode}): $body');
  }
}
