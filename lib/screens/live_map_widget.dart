import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'location_service.dart';

class LiveMapWidget extends StatefulWidget {
  final double? truckLat;
  final double? truckLng;

  const LiveMapWidget({
    super.key,
    this.truckLat,
    this.truckLng,
  });

  @override
  State<LiveMapWidget> createState() => _LiveMapWidgetState();
}

class _LiveMapWidgetState extends State<LiveMapWidget> {
  final MapController _mapController = MapController();
  LatLng? _userLatLng;
  String? _error;
  bool _loading = true;

  // Demo truck (QC area) if no real GPS yet
  static const _demoTruck = LatLng(14.6091, 121.0223);
  static const _fallback = LatLng(14.5995, 120.9842); // Manila

  @override
  void initState() {
    super.initState();
    _loadUserLocation();
  }

  LatLng get _truckLatLng {
    if (widget.truckLat != null && widget.truckLng != null) {
      return LatLng(widget.truckLat!, widget.truckLng!);
    }
    return _demoTruck;
  }

  Future<void> _loadUserLocation() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final pos = await LocationService.getPositionIfAllowed().timeout(
        const Duration(seconds: 8),
        onTimeout: () => null,
      );
      if (!mounted) return;

      if (pos == null) {
        setState(() {
          _userLatLng = _fallback;
          _loading = false;
          _error =
              'Location off or denied. Enable in Profile → Privacy, then allow permission.';
        });
      } else {
        setState(() {
          _userLatLng = LatLng(pos.latitude, pos.longitude);
          _loading = false;
        });
      }
    } catch (_) {
      if (!mounted) return;
      setState(() {
        _userLatLng = _fallback;
        _loading = false;
        _error = 'Could not get location. Showing default map.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const ColoredBox(
        color: Color(0xFFE8EBE6),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    final user = _userLatLng ?? _fallback;
    final truck = _truckLatLng;

    return Column(
      children: [
        if (_error != null)
          Material(
            color: const Color(0xFFFFDAD6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.info_outline,
                      size: 18, color: Color(0xFFBA1A1A)),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _error!,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFFBA1A1A),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        Expanded(
          child: FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: user,
              initialZoom: 14,
              interactionOptions: const InteractionOptions(
                flags: InteractiveFlag.all,
              ),
            ),
            children: [
              // Carto tiles — more reliable on emulator than OSM direct
              TileLayer(
                urlTemplate:
                    'https://{s}.basemaps.cartocdn.com/rastertiles/voyager/{z}/{x}/{y}.png',
                subdomains: const ['a', 'b', 'c', 'd'],
                userAgentPackageName: 'com.example.clientapp',
                maxZoom: 19,
              ),
              MarkerLayer(
                markers: [
                  // Your location
                  Marker(
                    point: user,
                    width: 48,
                    height: 48,
                    child: const Icon(
                      Icons.location_on,
                      color: Color(0xFF006D38),
                      size: 42,
                    ),
                  ),
                  // Service truck
                  Marker(
                    point: truck,
                    width: 52,
                    height: 52,
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF003D1A),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white, width: 2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.25),
                            blurRadius: 6,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.local_shipping,
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}