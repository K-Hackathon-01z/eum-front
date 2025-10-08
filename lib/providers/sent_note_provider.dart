import 'package:flutter/material.dart';
import '../models/note/sent_note.dart';
import '../../services/user/sent_note_service.dart';

class SentNoteProvider extends ChangeNotifier {
  List<SentNote> _notes = [];
  bool _isLoading = false;
  String? _error;

  final SentNoteService _service = SentNoteService();

  List<SentNote> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchSentNotes(int userId) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _service.fetchSentNotes(userId);
      _notes = data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
