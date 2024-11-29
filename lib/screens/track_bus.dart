import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kfupm_smart_bus_system/api/api_service.dart';
import 'dart:async';

class TrackBus extends StatefulWidget {
  const TrackBus({super.key});

  @override
  State<TrackBus> createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
  Timer? timer;
  bool isLoading = true;

  BitmapDescriptor? busIcon;
  Map<String, Marker> _markers = {}; // Using a Map instead of List

  Future<void> getBusIcon() async {
    busIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(24, 24)),
      'assets/images/bus_icon.png',
    );
  }

  @override
  void initState() {
    super.initState();
    getBusIcon().then((_) {
      _getBusesLocation().then((_) {
        setState(() {
          isLoading = false;
        });
        // Start the periodic timer after loading the initial data
        timer?.cancel();
        timer = Timer.periodic(
          const Duration(seconds: 5),
          (Timer t) => _getBusesLocation(),
        );
      });
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  late GoogleMapController mapController;
  final LatLngBounds kfupmBounds = LatLngBounds(
    southwest: const LatLng(26.302883027647383, 50.134502224126315),
    northeast: const LatLng(26.314681, 50.156939),
  );
  final LatLng kfupmCenter =
      const LatLng(26.307048543732158, 50.145802165049304);

  Future<void> _getBusesLocation() async {
    if (!mounted || busIcon == null) return;

    List busesLocation = await getAssetsLatestPositions();
    if (mounted) {
      // Collect all marker updates
      final Map<String, Marker> updatedMarkers = {};
      for (var bus in busesLocation) {
        String busId = bus['assetId'].toString();
        LatLng newPosition =
            LatLng(bus['locationLog'][0], bus['locationLog'][1]);

        // Update or add marker to the local map
        updatedMarkers[busId] = _markers.containsKey(busId)
            ? _markers[busId]!.copyWith(positionParam: newPosition)
            : Marker(
                markerId: MarkerId(busId),
                position: newPosition,
                icon: busIcon!);
      }

      // Update markers once
      setState(() {
        _markers = updatedMarkers;
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getBusesLocation();
    mapController.moveCamera(CameraUpdate.newLatLng(kfupmCenter));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF179C3D),
              ),
            )
          : GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: kfupmCenter,
                zoom: 15.0,
              ),
              minMaxZoomPreference: const MinMaxZoomPreference(15.0, 21.0),
              cameraTargetBounds: CameraTargetBounds(kfupmBounds),
              compassEnabled: false,
              tiltGesturesEnabled: false,
              rotateGesturesEnabled: false,
              markers: _markers.values.toSet(), // Convert map values to a Set
            ),
    );
  }
}
