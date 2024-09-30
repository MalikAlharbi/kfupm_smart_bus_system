import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';

class SummaryPage extends StatefulWidget {
  const SummaryPage({super.key});

  Widget build(BuildContext context) {
    return _generateSummaryReport(context);
  }
  
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

  Widget _generateSummaryReport(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopAppBar(),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _buildRequestNumberCard(),
                    _generateData(),
                  ],
                ),
              ),
            ),
            BottomBar(),
          ],
        ),
      ),
    );
  }

  Widget _generateData() {
    return const Column(
      children: [
        Text("TEST"),
        Text("TEST1"),
        Text("TEST2"),
        Text("TEST3"),
        Text("TEST4"),
        Text("TEST5"),
        Text("TEST6"),
        Text("TEST7"),
        Text("TEST8"),
        Text("TEST9"),
        Text("TEST10"),
      ],
    );
  }

  Widget _buildRequestNumberCard() {
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFF179C3D),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(255, 0, 0, 0),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: Column(
        children: [
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Text(
                'Request number',
                style: TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: const Text(
                  '#21459',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
  

