import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final _map = MapController();
  LatLng? _pos;
  bool _loading = true;

  static const _fallback = LatLng(37.5665, 126.9780); // 서울 시청 근처
  static const _zoom = 14.0;

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
      if (perm == LocationPermission.deniedForever ||
          perm == LocationPermission.denied) {
        throw Exception('위치 권한이 필요합니다');
      }

      final p = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.low,
      );
      _pos = LatLng(p.latitude, p.longitude);
    } catch (_) {
      _pos = _fallback;
    } finally {
      if (!mounted) return;
      setState(() => _loading = false);
      _map.move(_pos ?? _fallback, _zoom);
    }
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
          FlutterMap(
            mapController: _map,
            options: MapOptions(
              initialCenter: center,
              initialZoom: _zoom,
              interactionOptions: const InteractionOptions(
                flags:
                    InteractiveFlag.pinchZoom |
                    InteractiveFlag.drag, // 가볍게 제스처 최소화
              ),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'eum_demo',
                retinaMode: true,
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    width: 44,
                    height: 44,
                    point: center,
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          colors: [Color(0xFF6D5BD0), Color(0xFF9785BA)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.25),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.my_location,
                          color: Colors.white,
                          size: 22,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          // 우하단 재센터 버튼
          Positioned(
            right: 16,
            bottom: 16,
            child: FloatingActionButton.small(
              heroTag: 'recenter',
              backgroundColor: const Color(0xFF6D5BD0),
              foregroundColor: Colors.white,
              onPressed: () => _map.move(_pos ?? _fallback, _zoom),
              child: const Icon(Icons.gps_fixed_rounded),
            ),
          ),
        ],
      ),
    );
  }
}
