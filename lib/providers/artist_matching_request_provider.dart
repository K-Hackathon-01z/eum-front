import 'package:flutter/material.dart';
import 'package:eum_demo/models/artist/matching_request.dart';
import 'package:eum_demo/services/artist/message_service.dart';

class MatchingRequestProvider extends ChangeNotifier {
  final MatchingRequestService _service;
  MatchingRequestProvider({MatchingRequestService? service})
    : _service = service ?? MatchingRequestService();

  bool _isLoading = false;
  String? _error;
  List<MatchingRequest> _items = [];

  bool get isLoading => _isLoading;
  String? get error => _error;
  List<MatchingRequest> get items => _items;

  Future<void> fetch(int artisanId, {bool unreadOnly = false}) async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      _items = await _service.fetchByArtisanId(
        artisanId,
        unreadOnly: unreadOnly,
      );
    } catch (e) {
      _error = e.toString();
      _items = [];
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void reset() {
    _isLoading = false;
    _error = null;
    _items = [];
    notifyListeners();
  }
}
