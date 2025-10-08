import 'package:flutter/material.dart';
import '../models/creator/creator.dart';
import '../services/creator/creator_service.dart';

class ArtisanProvider extends ChangeNotifier {
  final ArtisanService _service;
  List<Creator> _artisans = [];
  bool _isLoading = false;
  String? _error;

  ArtisanProvider({required ArtisanService service}) : _service = service;

  List<Creator> get artisans => _artisans;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchAllArtisans() async {
    _isLoading = true;
    _error = null;
    notifyListeners();
    try {
      final data = await _service.fetchAllArtisans();
      _artisans = data;
    } catch (e) {
      _error = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
