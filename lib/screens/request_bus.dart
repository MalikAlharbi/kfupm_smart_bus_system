import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
import 'package:flutter/services.dart';

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
            MaterialPageRoute(builder: (context) => const RequestBus()),
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
            MaterialPageRoute(
                builder: (context) => const ReportProblemScreen()),
          );
          break;
      }
    }
  }

  final TextEditingController _dateController = TextEditingController();
  String? _errorMessage;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      _dateController.text = formattedDate;
      _validateDate(
          formattedDate); // Validate date after selecting from date picker
    }
  }

  void _formatDateInput() {
    final text = _dateController.text;
    if (text.length == 2 || text.length == 5) {
      _dateController.value = TextEditingValue(
        text: '$text/',
        selection: TextSelection.collapsed(offset: text.length + 1),
      );
    }
  }

  void _validateDate(String dateText) {
    final now = DateTime.now();
    final dateRegex =
        RegExp(r"^(0[1-9]|[12][0-9]|3[01])/(0[1-9]|1[0-2])/\d{4}$");

    setState(() {
      if (!dateRegex.hasMatch(dateText)) {
        _errorMessage = "Invalid format. Use dd/mm/yyyy.";
      } else {
        final parts = dateText.split('/');
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        final enteredDate = DateTime(year, month, day);

        if (month > 12 || day > 31) {
          _errorMessage = "Invalid day or month.";
        } else if (enteredDate
            .isBefore(DateTime(now.year, now.month, now.day))) {
          _errorMessage = "Date cannot be in the past.";
        } else {
          _errorMessage = null;
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _dateController.addListener(() {
      _formatDateInput();
      _validateDate(_dateController.text);
    });
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
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
      bottomNavigationBar:
          BottomBar(currentIndex: _currentIndex, onItemSelected: _onItemTapped),
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
          Column(
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
              TextField(
                controller: _dateController,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(
                      RegExp(r'[0-9/]')), // Allows only digits and "/"
                  LengthLimitingTextInputFormatter(
                      10), // Limits to 10 characters (dd/MM/yyyy)
                ],
                decoration: InputDecoration(
                  labelText: 'Pick a Date',
                  labelStyle: const TextStyle(
                    color: Colors.green,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                  floatingLabelBehavior: FloatingLabelBehavior.always,
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                  border: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gapPadding: 8,
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    gapPadding: 8,
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: _errorMessage == null ? Colors.green : Colors.red,
                      width: 2,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(8)),
                    gapPadding: 8,
                  ),
                  hintText: 'dd/mm/yyyy',
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_today, color: Colors.green),
                    onPressed: () => _selectDate(context),
                  ),
                ),
                onChanged: (text) {
                  _validateDate(text);
                },
              ),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
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
