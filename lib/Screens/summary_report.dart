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
    return _SummaryPageState();
  }
}

class _SummaryPageState extends State<SummaryPage> {
  @override
  Widget build(BuildContext context) {
    return widget.build(context);
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
                  _summaryReportText(),
                  const SizedBox(height: 5),
                  _generateRequestNumberCard(),
                  const SizedBox(height: 10),
                  _generateRows(),
                  const SizedBox(height: 10),
                  _generateNavigationButtons(),
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

Widget _summaryReportText() {
  return const Text(
    'Summary Report',
    style: TextStyle(
      fontSize: 30,
    ),
  );
}

Widget _generateRows() {
  return Column(
    children: [
      _generateSummaryReportData("KFUPM ID", "201900000", Icons.credit_card),
      _generateSummaryReportData("Assembely point", "KFUPM Mall", Icons.location_on),
      _generateSummaryReportData("Destination", "Building 54", Icons.location_on),
      _generateSummaryReportData("Date", "15/10/2024", Icons.calendar_today),
      _generateSummaryReportData("Assembly time", "12:00 pm", Icons.access_time),
      _generateSummaryReportData("Bus number", "37", Icons.directions_bus),

    ],
  );
}

Widget _generateRequestNumberCard() {
  return Container(
    margin: const EdgeInsets.all(10),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
      color: const Color(0xFF179C3D),
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color.fromARGB(100, 0, 0, 0),
          blurRadius: 5.0,
          offset: Offset(0, 5), // makes the shadow appear below the box
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
                  color: Colors.white),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 247, 246, 246),
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
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.start,
        //   children: const [
        //     Text(
        //       "test",
        //       style: TextStyle(
        //   fontSize: 18,
        //   color: Colors.white,
        //       ),
        //     ),
        //   ],
        // )   (this part will be used to make Request history page, was just testing it here!)
      ],
    ),
  );
}

Widget _generateSummaryReportData(String label, String value, IconData icon) {
  return Container(
    margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    decoration: BoxDecoration(
        color: const Color.fromARGB(255, 247, 246, 246),
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(30)),
    child: Row(
      children: [
        Expanded(
          child: Text(
            '$label:',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 5),
        Icon(icon, color: const Color(0xFF179C3D), size: 24),
      ],
    ),
  );
}

Widget _generateNavigationButtons(){
   return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            // navigate to previous report
          },
        ),
        IconButton(
          icon: const Icon(Icons.share),
          onPressed: () {
            // Handle share/export action
          },
        ),
        IconButton(
          icon: const Icon(Icons.arrow_forward_ios),
          onPressed: () {
            // navigate to next report
          },
        ),
      ],
    );
  }

