import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kfupm_smart_bus_system/api/api_service.dart';
import 'package:kfupm_smart_bus_system/data/station_data.dart'; // Import the stations data
import 'dart:async';
import 'dart:convert'; // For JSON parsing
import 'package:flutter/services.dart'; // For loading assets

class TrackBus extends StatefulWidget {
  const TrackBus({super.key});

  @override
  State<TrackBus> createState() => _TrackBusState();
}

class _TrackBusState extends State<TrackBus> {
  // Timer
  Timer? timer;
  // Loading state
  bool isLoading = true;

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

  // Station Icons
  late BitmapDescriptor maleStationIcon;
  late BitmapDescriptor femaleStationIcon;

  // Map style string
  String? mapStyle;

  @override
  void initState() {
    super.initState();
    _loadMapStyle();
    _loadIcons();
    _getBusesLocation().then((_) {
      setState(() {
        isLoading = false;
      });
      // Start the periodic timer after loading the initial data
      timer?.cancel(); // Cancel previous timers if any
      timer = Timer.periodic(
        const Duration(seconds: 5),
        (Timer t) => _getBusesLocation(),
      );
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> _loadMapStyle() async {
    mapStyle = await rootBundle.loadString('assets/custom_map.json');
  }

  Future<void> _loadIcons() async {
    maleStationIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(27, 27)),
      'assets/images/male_station.png',
    );
    femaleStationIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(27, 27)),
      'assets/images/female_station.png',
    );

    _addStationMarkers();
  }

  void _onStationTapped(
    String stationName,
    LatLng position,
    List<String> buildings,
  ) {
    String buildingString = '';
    for (var building in buildings) {
      if (buildings.indexOf(building) == buildings.length - 1) {
        buildingString += building + '.';
      } else {
        buildingString += building + ', ';
      }
    }
    // Placeholder functionality
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(stationName),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Buildings: $buildingString'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              mapController.hideMarkerInfoWindow(
                MarkerId(position.toString()),
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _addStationMarkers() {
    for (var station in stationLocations) {
      _markers.add(
        Marker(
          markerId: MarkerId('${station['position']}'),
          position: station['position'],
          icon: station['type'] == 'male' ? maleStationIcon : femaleStationIcon,
          infoWindow: InfoWindow(
            title: station['name'],
            snippet: 'Tap for details',
            onTap: () => _onStationTapped(
              station['name'],
              station['position'],
              station['buildings'],
            ),
          ),
        ),
      );
    }
  }

  Future<void> _getBusesLocation() async {
    if (!mounted) return; // Exit if the widget is not mounted
    try {
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
          _addStationMarkers();
          // Re-add station markers after clearing
        });
      }
    } catch (e) {
      print('Error fetching bus locations: $e');
    }
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
              onMapCreated: (controller) {
                mapController = controller;
                _getBusesLocation();
              },
              style: mapStyle, // Use the style property here
              initialCameraPosition: CameraPosition(
                target: kfupmCenter,
                zoom: 15.0,
              ),
              minMaxZoomPreference: const MinMaxZoomPreference(15.0, 21.0),
              cameraTargetBounds: CameraTargetBounds(kfupmBounds),
              // Restrict to 2D movement only
              compassEnabled: false,
              tiltGesturesEnabled: false,
              rotateGesturesEnabled: false,
              markers: Set.from(_markers),
            ),
    );
  }
}
