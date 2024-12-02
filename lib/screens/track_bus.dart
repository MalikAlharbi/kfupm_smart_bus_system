import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:async';
import 'package:kfupm_smart_bus_system/api/api_service.dart';

class TrackBus extends StatefulWidget {
  const TrackBus({super.key});

  @override
  State<TrackBus> createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
  StreamSubscription? _streamSubscription;
  bool isLoading = true;
  bool isUserInBounds = true;
  BitmapDescriptor? busIcon;
  Map<String, Marker> _markers = {};

  late GoogleMapController mapController;
  final LatLngBounds kfupmBounds = LatLngBounds(
    southwest: const LatLng(26.302883027647383, 50.134502224126315),
    northeast: const LatLng(26.314681, 50.156939),
  );
  final LatLng kfupmCenter =
      const LatLng(26.307048543732158, 50.145802165049304);

  Future<void> getBusIcon() async {
    busIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(24, 24)),
      'assets/images/bus_icon.png',
    );
  }

  Future<void> _getUserLocation() async {
    final permissionStatus = await Permission.location.request();
    if (permissionStatus.isGranted) {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.medium);
      LatLng userPosition = LatLng(position.latitude, position.longitude);
      setState(() {
        isUserInBounds = kfupmBounds.contains(userPosition);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getBusIcon().then((_) {
      _getUserLocation().then((_) {
        _startBusLocationUpdates();
      });
    });
  }

  void _startBusLocationUpdates() {
    _streamSubscription =
        getAssetsLatestPositionsStream().listen((busesLocation) {
      if (!mounted || busIcon == null) return;

      final Map<String, Marker> updatedMarkers = {};
      for (var bus in busesLocation) {
        String busId = bus['assetId'].toString();
        LatLng newPosition =
            LatLng(bus['locationLog'][0], bus['locationLog'][1]);

        if (_markers.containsKey(busId)) {
          LatLng existingPosition = _markers[busId]!.position;
          if (existingPosition.latitude != newPosition.latitude ||
              existingPosition.longitude != newPosition.longitude) {
            updatedMarkers[busId] =
                _markers[busId]!.copyWith(positionParam: newPosition);
          } else {
            updatedMarkers[busId] = _markers[busId]!;
          }
        } else {
          updatedMarkers[busId] = Marker(
            markerId: MarkerId(busId),
            position: newPosition,
            icon: busIcon!,
          );
        }
      }

      setState(() {
        _markers = updatedMarkers;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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
              markers: _markers.values.toSet(),
              myLocationEnabled: isUserInBounds,
              myLocationButtonEnabled: isUserInBounds,
            ),
    );
  }
}
