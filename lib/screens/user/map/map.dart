import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  LatLng? _pos;
  bool _loading = true;

  static const _fallback = LatLng(37.5665, 126.9780); // 서울 시청
  static const double _zoom = 14.0;

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      final enabled = await Geolocator.isLocationServiceEnabled();
      if (!enabled) throw Exception('위치 서비스 비활성화됨');

      var perm = await Geolocator.checkPermission();
      if (perm == LocationPermission.denied) {
        perm = await Geolocator.requestPermission();
      }
      if (perm == LocationPermission.deniedForever || perm == LocationPermission.denied) {
        throw Exception('위치 권한이 필요합니다');
      }

      final p = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      _pos = LatLng(p.latitude, p.longitude);
    } catch (_) {
      _pos = _fallback;
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
      final mapController = await _controller.future;
      mapController.moveCamera(CameraUpdate.newLatLngZoom(_pos ?? _fallback, _zoom));
    }
  }

  Future<void> _recenter() async {
    final mapController = await _controller.future;
    mapController.animateCamera(CameraUpdate.newLatLngZoom(_pos ?? _fallback, _zoom));
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final center = _pos ?? _fallback;

    return Scaffold(
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(target: center, zoom: _zoom),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            markers: {
              if (_pos != null)
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: _pos!,
                  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet),
                ),
            },
            myLocationButtonEnabled: false,
            zoomControlsEnabled: false,
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.small(
              heroTag: 'recenter',
              backgroundColor: const Color(0xFF6D5BD0),
              foregroundColor: Colors.white,
              onPressed: _recenter,
              child: const Icon(Icons.gps_fixed_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
