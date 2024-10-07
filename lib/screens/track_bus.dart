import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TrackBus extends StatefulWidget {
  const TrackBus({super.key});

  @override
  State<TrackBus> createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
  late GoogleMapController mapController;

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
      ),
    );
  }
}
