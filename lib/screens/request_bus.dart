import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kfupm_smart_bus_system/Screens/request_bus_details_screen.dart';

class RequestBus extends StatefulWidget {
  const RequestBus({super.key});

  @override
  State<RequestBus> createState() => _RequestBusState();
}

class _RequestBusState extends State<RequestBus> {
  final TextEditingController keyController = TextEditingController();
  String? selectedClub;
  String? passKeyError;
  String? clubSelectionError; // Error for the dropdown

  // Dynamic map for clubs and their keys
  final Map<String, String> clubsWithKeys = {
    'Photography Club': '123456',
    'Robotics Club': '654321',
    'Art Club': '111111',
    'Computer Club': '222222',
    'IET Club': '333333',
    'IE Club': '444444',
    'UAS2030 Club': '555555',
    'Electrical Club': '666666',
    'Toastmasters Club': '777777',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Dropdown for selecting club
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DropdownButtonFormField<String>(
                  value: selectedClub,
                  decoration: const InputDecoration(
                    labelText: 'Select Club',
                    labelStyle: TextStyle(fontSize: 19),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(16),
                      ),
                    ),
                    prefixIcon: Icon(Icons.group),
                  ),
                  items: clubsWithKeys.keys.map((club) {
                    return DropdownMenuItem(
                      value: club,
                      child: Text(
                        club,
                        style: const TextStyle(fontSize: 19),
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedClub = value;
                      clubSelectionError = null; // Clear error when a club is selected
                      keyController.clear(); // Clear the pass key field
                    });
                  },
                ),
                if (clubSelectionError != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      clubSelectionError!,
                      style: const TextStyle(color: Colors.red, fontSize: 14),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 20),

            // TextField for entering pass key
            TextField(
              controller: keyController,
              decoration: InputDecoration(
                labelText: 'Enter Key',
                labelStyle: const TextStyle(fontSize: 19),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                errorText: passKeyError,
                prefixIcon: const Icon(Icons.vpn_key),
              ),
              keyboardType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
                LengthLimitingTextInputFormatter(6),
              ],
              obscureText: true,
            ),
            const SizedBox(height: 30),

            // Submit button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    // Reset errors
                    clubSelectionError = null;
                    passKeyError = null;

                    // Validate the club selection
                    if (selectedClub == null) {
                      clubSelectionError = 'Please select a club';
                    } else {
                      final enteredKey = keyController.text;
                      final expectedKey = clubsWithKeys[selectedClub!];

                      // Validate the pass key
                      if (enteredKey != expectedKey) {
                        passKeyError = 'Wrong pass key, please retry';
                      } else {
                        // Clear errors and navigate to the next page
                        passKeyError = null;
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    const RequestBusDetailsPage(),
                            transitionsBuilder:
                                (context, animation, secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var fadeTween = Tween<double>(begin: 0.0, end: 1.0);

                              return FadeTransition(
                                opacity: animation.drive(fadeTween),
                                child: SlideTransition(
                                  position: animation.drive(tween),
                                  child: child,
                                ),
                              );
                            },
                          ),
                        );
                      }
                    }
                  });
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Enter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
