import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackBus extends StatefulWidget {
  const TrackBus({super.key});

  @override
  State<TrackBus> createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
  late GoogleMapController mapController;

  final LatLngBounds kfupmBounds = LatLngBounds(
    southwest: const LatLng(26.302883027647383, 50.134502224126315),
    northeast: const LatLng(26.314681, 50.156939),
  );

  final LatLng kfupmCenter =
      const LatLng(26.307048543732158, 50.145802165049304);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: kfupmCenter,
          zoom: 15.0,
        ),
        minMaxZoomPreference: const MinMaxZoomPreference(15.0, 18.0),
        cameraTargetBounds: CameraTargetBounds(kfupmBounds),
      ),
    );
  }
}
