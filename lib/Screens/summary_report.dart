import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';

class SummaryPage extends StatelessWidget {
  const SummaryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return _generateSummaryReport(context);
  }


  Widget _generateSummaryReport(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopAppBar(),
            const Expanded(
              child: SingleChildScrollView(
                
              ),
            ),
            BottomBar(),
          ],
        ),
      ),
    );
  }
}

