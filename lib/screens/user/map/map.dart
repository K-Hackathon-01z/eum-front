import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  LatLng? _me;
  final Set<Marker> _markers = {};

  @override
  void initState() {
    super.initState();
    _initLocation();
  }

  Future<void> _initLocation() async {
    try {
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) throw Exception('위치 서비스가 꺼져 있습니다.');
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw Exception('위치 권한이 거부되었습니다.');
      }
      final pos = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.best,
      );
      final me = LatLng(pos.latitude, pos.longitude);
      if (!mounted) return;
      setState(() {
        _me = me;
        _markers
          ..removeWhere((m) => m.markerId.value == 'me')
          ..add(Marker(markerId: const MarkerId('me'), position: me));
      });
      await _controller?.animateCamera(CameraUpdate.newLatLngZoom(me, 16));
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('현재 위치를 가져올 수 없습니다: $e')));
    }
  }

  // Build the map screen UI
  @override
  Widget build(BuildContext context) {
    final initial = _me ?? const LatLng(37.5665, 126.9780); // 서울 시청 fallback
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(target: initial, zoom: 14),
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: _markers,
        onMapCreated: (c) {
          _controller = c;
          if (_me != null) {
            _controller!.moveCamera(CameraUpdate.newLatLngZoom(_me!, 16));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _initLocation,
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
