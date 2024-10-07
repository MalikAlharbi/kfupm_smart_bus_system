import 'package:flutter/material.dart';
import 'screens/track_bus.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color(0xFF179C3D),
      scaffoldBackgroundColor: Colors.grey[100],
    ),
    home: Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopAppBar(),
            const Spacer(),
            const SizedBox(
              height: 630,
              child:
                  TrackBus(), // This will now use the Scaffold from TrackBus.
            ),
            const Spacer(),
            BottomBar(),
          ],
        ),
      ),
    ),
  ));
}
