import 'package:flutter/material.dart';
import '../models/note/send_note.dart';
import '../services/user/send_note_service.dart';

class SendNoteProvider extends ChangeNotifier {
  bool _isLoading = false;
  String? _error;
  bool _success = false;

  final SendNoteService _service = SendNoteService();

  bool get isLoading => _isLoading;
  String? get error => _error;
  bool get success => _success;

  Future<void> sendNote(SendNote request) async {
    _isLoading = true;
    _error = null;
    _success = false;
    notifyListeners();
    try {
      final result = await _service.sendNote(request);
      _success = result;
    } catch (e) {
      _error = e.toString();
      _success = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
