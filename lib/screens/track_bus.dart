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
  //timer
  Timer? timer;
  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
        const Duration(seconds: 1), (Timer t) => _getBusesLocation());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Google Maps and LatLng values
  late GoogleMapController mapController;
  final LatLngBounds kfupmBounds = LatLngBounds(
    southwest: const LatLng(26.302883027647383, 50.134502224126315),
    northeast: const LatLng(26.314681, 50.156939),
  );
  final LatLng kfupmCenter =
      const LatLng(26.307048543732158, 50.145802165049304);

  // Buses location
  final List<Marker> _markers = [];
  Future<void> _getBusesLocation() async {
    if (!mounted) return; // Exit if the widget is not mounted
    List busesLocation = await getAssetsLatestPositions();
    BitmapDescriptor busIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(24, 24)),
      'assets/images/bus_icon.png',
    );

    if (mounted) {
      setState(() {
        _markers.clear();
        for (var bus in busesLocation) {
          _markers.add(Marker(
            markerId: MarkerId(bus['assetId'].toString()),
            position: LatLng(bus['locationLog'][0], bus['locationLog'][1]),
            icon: busIcon,
          ));
        }
      });
    }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getBusesLocation();
    // Ensure the map centers on the correct location after creation
    mapController.moveCamera(CameraUpdate.newLatLng(kfupmCenter));
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
        minMaxZoomPreference: const MinMaxZoomPreference(15.0, 21.0),
        cameraTargetBounds: CameraTargetBounds(kfupmBounds),
        //Restrict to 2D movment only
        compassEnabled: false,
        tiltGesturesEnabled: false,
        rotateGesturesEnabled: false,
        markers: Set.from(_markers),
      ),
    );
  }
}
