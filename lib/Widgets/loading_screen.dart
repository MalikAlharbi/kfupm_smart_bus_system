import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/screens/track_bus.dart';
import 'package:kfupm_smart_bus_system/screens/widget_main.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    // Simulate a delay before navigating to the target screen
    Future.delayed(Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => TrackBus()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ColorFiltered(
              colorFilter: const ColorFilter.mode(
                Color(0xFF179C3D),
                BlendMode.srcIn,
              ),
              child: Image.asset(
                'assets/images/loadingPage.gif',
                height: 500,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.error,
                    color: Colors.red,
                    size: 120,
                  );
                },
              ),
            ),
      ),
    );
  }
}

