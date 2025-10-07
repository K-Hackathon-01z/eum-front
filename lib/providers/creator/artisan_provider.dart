import 'package:flutter/material.dart';
import '../../models/creator/artisan.dart';
import '../../services/creator/artisan_service.dart';

class ArtisanProvider extends ChangeNotifier {
  final ArtisanService _service;
  List<Artisan> _artisans = [];
  bool _isLoading = false;
  String? _error;

  ArtisanProvider({required ArtisanService service}) : _service = service;

  List<Artisan> get artisans => _artisans;
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
