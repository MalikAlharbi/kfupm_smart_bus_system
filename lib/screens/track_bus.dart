import 'package:animated_marker/animated_marker.dart';
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



  late Set<Marker> tempMarker={};
 void _startBusLocationUpdates() {
    // LatLng oldPosition = getInitialLocation();
    
    late LatLng newPosition;
    _streamSubscription =
      getAssetsLatestPositionsStream().listen((busesLocation) {
      if (!mounted || busIcon == null) return;

      final Map<String, Marker> updatedMarkers = {};
     
   
      for (var bus in busesLocation) {
        String busId = bus['assetId'].toString();
         newPosition =
            LatLng(bus['locationLog'][0], bus['locationLog'][1]);


        
      
        updatedMarkers[busId] = _markers.containsKey(busId)
            ? _markers[busId]!.copyWith(positionParam: newPosition)
            : Marker(
                markerId: MarkerId(busId),
                position: newPosition,
                icon: busIcon!);
                  
                     
                   
      }


      setState(() {
        _markers = updatedMarkers;
        isLoading = false;
         tempMarker = Set<Marker>.from(updatedMarkers.values);
        // oldPosition = newPosition;
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
    return ScaffoldTwo();
  }


  
  Widget ScaffoldTwo(){
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xFF179C3D),
              ),
            )
          : AnimatedMarker(
            // staticMarkers: ,
            animatedMarkers: tempMarker,
            duration: Duration(seconds: 7),
            fps: 30,
            
            builder: (BuildContext context, Set<Marker> animatedMarkers) { 
              return GoogleMap(
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
                markers: animatedMarkers,
                myLocationEnabled: isUserInBounds,
                myLocationButtonEnabled: isUserInBounds,
              );
             },
            
          ),
    );
  }
}
