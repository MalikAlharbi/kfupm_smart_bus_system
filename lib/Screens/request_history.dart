import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Screens/summary_report.dart';
import 'package:kfupm_smart_bus_system/Widgets/old_request_card.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';
import 'package:kfupm_smart_bus_system/screens/contact_us.dart';
import 'package:kfupm_smart_bus_system/screens/track_bus.dart';

class RequestHistoryScreen extends StatelessWidget{
  const RequestHistoryScreen({super.key});
  
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
