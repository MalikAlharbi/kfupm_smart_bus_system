import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/screens/request_bus.dart';
import 'screens/widget_main.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color(0xFF179C3D),
      scaffoldBackgroundColor: Colors.grey[100],
    ),
    home: Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopAppBar(),
            const Expanded(
              child: Widgetmain(),
            ),
            BottomBar(),
          ],
        ),
      ),
    ),
  ));
}
