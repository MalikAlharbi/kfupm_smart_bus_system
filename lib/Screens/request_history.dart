import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Widgets/old_request_card.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';

class RequestHistoryScreen extends StatelessWidget {
  const RequestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Use the AppBar from the Scaffold for the title
      appBar: AppBar(
        title: const Text('Request History'),
      ),
      body: Column(
        children: [
          // Fixed at the top
          TopAppBar(),
          Expanded(
            child: ListView(
              children: const [
                OldRequestCard(requestNumber: 21459, status: 'Pending'),
                OldRequestCard(requestNumber: 21460, status: 'Approved'),
                OldRequestCard(requestNumber: 21460, status: 'Approved'),
                OldRequestCard(requestNumber: 21460, status: 'Approved'),
                OldRequestCard(requestNumber: 21460, status: 'Approved'),
                OldRequestCard(requestNumber: 21460, status: 'Approved'),
                OldRequestCard(requestNumber: 21461, status: 'Rejected'),
                OldRequestCard(requestNumber: 21462, status: 'Rejected'),
              ],
            ),
          ),
        ],
      ),
      // Fixed at the bottom
      bottomNavigationBar: BottomBar(),
    );
  }
}