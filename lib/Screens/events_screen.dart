import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/screens/contact_us.dart';
import 'package:kfupm_smart_bus_system/screens/report_problem_screen.dart';
import 'package:kfupm_smart_bus_system/screens/request_bus.dart';
import 'package:kfupm_smart_bus_system/screens/track_bus.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({super.key});
  @override
  State<EventsScreen> createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  int _currentIndex = 1; // Default index for the "Smart Buses" screen

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
            MaterialPageRoute(builder: (context) => const EventsScreen()),
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
            MaterialPageRoute(builder: (context) => const ReportProblemScreen()),
          );
          break;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Buses',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onItemSelected: _onItemTapped,
      ),
      body: const Center(
        child: Text('events screen'),
      ),
    );
  }
}
