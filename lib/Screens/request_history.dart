import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Screens/summary_report.dart';
import 'package:kfupm_smart_bus_system/Widgets/old_request_card.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';

class RequestHistoryScreen extends StatelessWidget {
  const RequestHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(5),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: TopAppBar(),
        ),
        bottomNavigationBar: const BottomBar(),
        body: Expanded(
          child: ListView(
            children: [
              InkWell(
                child: OldRequestCard(requestNumber: 21459, status: 'Pending'),
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (ctx) => const SummaryPage(),
                    ),
                  );
                },
              ),
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
      ),
    );
  }
}
