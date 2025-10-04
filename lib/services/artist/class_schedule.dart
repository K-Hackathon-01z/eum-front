import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ClassScheduleService {
  static const _base = 'http://3.26.220.20:8080';
  static const _path = '/api/class-schedule';

  final http.Client _client;
  ClassScheduleService({http.Client? client})
    : _client = client ?? http.Client();

  Future<Map<String, dynamic>> createSchedule({
    required int classId,
    required DateTime date,
    required TimeOfDay time,
    required int capacity,
    int currentCount = 0,
  }) async {
    String _p2(int v) => v.toString().padLeft(2, '0');
    final body = {
      'classId': classId,
      'date': '${date.year}-${_p2(date.month)}-${_p2(date.day)}',
      'timeSlot': '${_p2(time.hour)}:${_p2(time.minute)}:00',
      'capacity': capacity,
      'currentCount': currentCount,
    };

    final res = await _client.post(
      Uri.parse('$_base$_path'),
      headers: {'Content-Type': 'application/json', 'accept': '*/*'},
      body: jsonEncode(body),
    );

    if (res.statusCode != 200) {
      throw Exception('클래스 생성 실패: ${res.statusCode} / ${res.body}');
    }
    return jsonDecode(res.body) as Map<String, dynamic>;
  }
}
