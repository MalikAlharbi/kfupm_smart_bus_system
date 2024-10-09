import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.all(5),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: TopAppBar(),
        ),
        bottomNavigationBar: BottomBar(),
        body: const Center(
          child: Text('Contact Us'),
        ),
      ),
    );
  }
}
