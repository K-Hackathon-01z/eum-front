import 'package:flutter/material.dart';
import 'package:eum_demo/models/artist/artist.dart';

class ArtistProvider extends ChangeNotifier {
  Artist? _current;
  Artist? get current => _current;

  void setCurrent(Artist artist) {
    _current = artist;
    notifyListeners();
  }

  void reset() {
    _current = null;
    notifyListeners();
  }
}
