import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Screens/request_history.dart';
import 'package:kfupm_smart_bus_system/Widgets/text_field.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';
import 'package:kfupm_smart_bus_system/screens/contact_us.dart';
import 'package:kfupm_smart_bus_system/screens/events_screen.dart';
import 'package:kfupm_smart_bus_system/screens/report_problem_screen.dart';
import 'package:kfupm_smart_bus_system/screens/track_bus.dart';
import 'package:kfupm_smart_bus_system/special_buttons/date_picker_button.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class RequestBus extends StatefulWidget {
  const RequestBus({super.key});

  @override
  State<StatefulWidget> createState() {
    return _RequestBusState();
  }
}

class _RequestBusState extends State<RequestBus> {
  int randomNumber = Random().nextInt(200);

  int _currentIndex = 0; // Default index for the "Smart Buses" screen

  void _onItemTapped(int index) {
    // Check if the selected index is different from the current index
    if (index != _currentIndex) {
      setState(() {
        _currentIndex = index;
      });

      // Navigate based on the selected index
      switch (index) {
        case 0:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) =>  const RequestBus()),
          );
          break;
        case 1:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const EventsScreen()),
          );
          break;
        case 2:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const TrackBus()),
          );
          break;
        case 3:
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const ReportProblemScreen()),
          );
          break;
      }
    }
  }

  @override
  Widget build(context) {
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
      bottomNavigationBar: BottomBar(currentIndex: _currentIndex, onItemSelected: _onItemTapped),
        body: Column(
          children: [
            // First child: Column with 3 sub-children
            Column(
              children: [
                // image of KFUPM Buses
                const SizedBox(
                  height: 15,
                ),
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.green),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: const Image(
                      image: AssetImage("assets/images/Bus.jpg"),
                      width: 221,
                    ),
                  ),
                ),

                const SizedBox(
                  height: 8,
                ),

                // a button that allows the user to enter a specific date and store the date recieved
                DatePickerButton(),
                
                const SizedBox(
                  height: 8,
                ),

                // a unique number generated that represent request number
                // NEED UPDATE
                Container(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Request Number: #",
                      style: TextStyle(
                        fontSize: 25,
                      ),
                    ),
                    Text(
                      randomNumber.toString(),
                      style: const TextStyle(
                          fontSize: 25, fontStyle: FontStyle.italic),
                    ),
                  ],
                )),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
            // Second child: Column with 5 sub-children
            const Column(
              children: [
                TextFieldBus(
                  title: 'KFUPM ID',
                ),
                TextFieldBus(
                  title: 'Purpose',
                ),
                TextFieldBus(
                  title: 'Destination',
                ),
                TextFieldBus(
                  title: 'Time',
                ),
              ],
            ),
            // Third child: Row with 2 sub-children
            const SizedBox(
              height: 20,
            ),
            Row(
              children: [
                const Spacer(),
                SizedBox(
                    width: 130,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF179C3D)),
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (ctx) => const RequestHistoryScreen(),
                            ),
                          );
                        },
                        child: Container(
                          decoration: const BoxDecoration(),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Column(
                              children: [
                                Text(
                                  "View",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "Request",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ))),
                const Spacer(),
                SizedBox(
                    width: 130,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF179C3D)),
                      onPressed: () {},
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Request",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )),
                const Spacer(),
              ],
            ),
          ],
        ),
      );
  }
}
