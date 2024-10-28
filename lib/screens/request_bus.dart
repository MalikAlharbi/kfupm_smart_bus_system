import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Screens/request_history.dart';
import 'package:kfupm_smart_bus_system/Widgets/text_field.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';
import 'package:kfupm_smart_bus_system/special_buttons/date_picker_button.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class RequestBus extends StatefulWidget {
  const RequestBus({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _RequestBusState();
  }
}

class _RequestBusState extends State<RequestBus> {
  int randomNumber = Random().nextInt(200);
  @override
  Widget build(context) {
    return SafeArea(
      minimum: const EdgeInsets.all(5),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: TopAppBar(),
        ),
        bottomNavigationBar: BottomBar(),
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
                Container(child: DatePickerButton()),
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
                  title: 'KFUPM ID:',
                ),
                TextFieldBus(
                  title: 'Purpose:',
                ),
                TextFieldBus(
                  title: 'Destination:',
                ),
                TextFieldBus(
                  title: 'Time: ',
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
                          Navigator.of(context).pushReplacement(
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
      ),
    );
  }
}
