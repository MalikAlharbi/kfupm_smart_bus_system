import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Screens/summary_report.dart';
import 'package:kfupm_smart_bus_system/Widgets/old_request_card.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';
import 'package:kfupm_smart_bus_system/screens/contact_us.dart';
import 'package:kfupm_smart_bus_system/screens/track_bus.dart';

class RequestHistoryScreen extends StatefulWidget {
  @override
  State<RequestHistoryScreen> createState() => _RequestHistoryScreenState();
}

class _RequestHistoryScreenState extends State<RequestHistoryScreen> {
  int _currentIndex = 0; // Default index for the "Smart Buses" screen

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
            MaterialPageRoute(builder: (context) => RequestHistoryScreen()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => TrackBus()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => ContactUs()),
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
      bottomNavigationBar: BottomBar(currentIndex: _currentIndex, onItemSelected: _onItemTapped),
      body: ListView(
          children: [
            InkWell(
              child:
                  const OldRequestCard(requestNumber: 21459, status: 'Pending'),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const SummaryPage(),
                  ),
                );
              },
            ),
            const OldRequestCard(requestNumber: 21460, status: 'Approved'),
            const OldRequestCard(requestNumber: 21460, status: 'Approved'),
            const OldRequestCard(requestNumber: 21460, status: 'Approved'),
            const OldRequestCard(requestNumber: 21460, status: 'Approved'),
            const OldRequestCard(requestNumber: 21460, status: 'Approved'),
            const OldRequestCard(requestNumber: 21461, status: 'Rejected'),
            const OldRequestCard(requestNumber: 21462, status: 'Rejected'),
          ],
        ),
      );
  }
}
