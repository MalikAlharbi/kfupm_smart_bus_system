import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kfupm_smart_bus_system/api/api_service.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';
import 'dart:async';

import 'package:kfupm_smart_bus_system/screens/contact_us.dart';
import 'package:kfupm_smart_bus_system/screens/events_screen.dart';
import 'package:kfupm_smart_bus_system/screens/request_bus.dart';
import 'package:kfupm_smart_bus_system/screens/request_history.dart';

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
        const Duration(seconds: 5), (Timer t) => _getBusesLocation());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  //google maps and LatLng values
  late GoogleMapController mapController;
  final LatLngBounds kfupmBounds = LatLngBounds(
    southwest: const LatLng(26.302883027647383, 50.134502224126315),
    northeast: const LatLng(26.314681, 50.156939),
  );
  final LatLng kfupmCenter =
      const LatLng(26.307048543732158, 50.145802165049304);

  // buses location
  final List<Marker> _markers = [];
  Future<void> _getBusesLocation() async {
    List busesLocation = await getAssetsLatestPositions();
    BitmapDescriptor busIcon = await BitmapDescriptor.asset(
        const ImageConfiguration(size: Size(24, 24)),
        'assets/images/bus_icon.png');
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

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    _getBusesLocation();
  }

  int _currentIndex = 2; // Default index for the "Smart Buses" screen

  void _onItemTapped(int index) {
    // Check if the selected index is different from the current index
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });

      // Navigate based on the selected index
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RequestBus()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => EventsScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TrackBus()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ContactUs()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text("Smart Buses"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Container(
          color: Colors.grey[200], // Placeholder for map or content
        ),
        bottomNavigationBar: BottomBar(
          currentIndex: _currentIndex,
          onItemSelected: _onItemTapped,
        ));

    // return SafeArea(
    //     minimum: const EdgeInsets.all(5),
    //     child: Scaffold(
    //       appBar: AppBar(
    //         flexibleSpace: TopAppBar(),
    //       ),
    //       bottomNavigationBar: BottomBar(),
    //       body: GoogleMap(
    //         onMapCreated: _onMapCreated,
    //         initialCameraPosition: CameraPosition(
    //           target: kfupmCenter,
    //           zoom: 15.0,
    //         ),
    //         minMaxZoomPreference: const MinMaxZoomPreference(15.0, 21.0),
    //         cameraTargetBounds: CameraTargetBounds(kfupmBounds),
    //         //Restrict to 2D movment only
    //         compassEnabled: false,
    //         tiltGesturesEnabled: false,
    //         rotateGesturesEnabled: false,
    //         markers: Set.from(_markers),
    //       ),
    //     ));
  }
}
