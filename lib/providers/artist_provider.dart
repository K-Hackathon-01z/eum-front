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

  void updateProfile({String? mainWorks, String? biography, String? photoUrl}) {
    if (_current == null) return;
    _current = Artist(
      id: _current!.id,
      skillId: _current!.skillId,
      email: _current!.email,
      name: _current!.name,
      photoUrl: photoUrl ?? _current!.photoUrl,
      mainWorks: mainWorks ?? _current!.mainWorks,
      biography: biography ?? _current!.biography,
    );
    notifyListeners();
  }
}
