import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Widgets/text_field.dart';
import 'package:kfupm_smart_bus_system/special_buttons/date_picker_button.dart';
import 'package:uuid/uuid.dart';
import 'dart:math';

class RequestBus extends StatefulWidget {
  RequestBus({super.key});

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
    return Column(
      children: [
        // First child: Column with 3 sub-children
        Column(
          children: [
            // image of KFUPM Buses
            SizedBox(
              height: 15,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image(
                  image: AssetImage("assets/images/Bus.jpg"),
                  width: 221,
                ),
              ),
            ),

            SizedBox(
              height: 8,
            ),

            // a button that allows the user to enter a specific date and store the date recieved
            Container(child: DatePickerButton()),
            SizedBox(
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
          ],
        ),
        // Second child: Column with 5 sub-children
        Column(
          children: [
            // Container(child: Text('Second column - Child 1')),
            // Container(child: Text('Second column - Child 2')),
            // Container(child: Text('Second column - Child 3')),
            // Container(child: Text('Second column - Child 4')),
            // Container(child: Text('Second column - Child 5')),
            SizedBox(
              height: 15,
            ),
            TextFieldBus(
              title: 'KFUPM ID:',
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldBus(
              title: 'Purpose:',
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldBus(
              title: 'Destination:',
            ),
            SizedBox(
              height: 15,
            ),
            TextFieldBus(
              title: 'Time: ',
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ),
        // Third child: Row with 2 sub-children
        Row(
          children: [
            Spacer(),
            Container(
                width: 130,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      decoration: BoxDecoration(),
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Text(
                              "View",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Request",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ))),
            Spacer(),
            Container(
                width: 130,
                child: ElevatedButton(
                    onPressed: () {},
                    child: Container(
                      child: const Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Column(
                          children: [
                            Text(
                              "Submit",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            ),
                            Text(
                              "Request",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    ))),
            Spacer(),
          ],
        ),
      ],
    );
  }
}
