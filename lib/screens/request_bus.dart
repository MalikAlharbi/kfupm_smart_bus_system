import 'package:flutter/cupertino.dart';
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
    'Photography Club': '1',
    'Robotics Club': '1',
    'Art Club': '1',
    'Computer Club': '1',
    'IET Club': '1',
    'IE Club': '1',
    'UAS2030 Club': '1',
    'Electrical Club': '1',
    'Toastmasters Club': '1',
  };

  void _showClubPicker(BuildContext context) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 216,
          padding: const EdgeInsets.only(top: 6.0),
          margin: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          color: CupertinoColors.systemBackground.resolveFrom(context),
          child: SafeArea(
            top: false,
            child: CupertinoPicker(
              magnification: 1.22,
              squeeze: 1.2,
              useMagnifier: true,
              itemExtent: 32.0,
              onSelectedItemChanged: (int selectedItem) {
                setState(() {
                  selectedClub = clubsWithKeys.keys.toList()[selectedItem];
                  clubSelectionError = null;
                  keyController.clear();
                });
              },
              children: List<Widget>.generate(clubsWithKeys.keys.length, (int index) {
                return Center(
                  child: Text(
                    clubsWithKeys.keys.toList()[index],
                    style: const TextStyle(fontSize: 22.0),
                  ),
                );
              }),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isIOS = Theme.of(context).platform == TargetPlatform.iOS;

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
                if (isIOS)
                  CupertinoButton(
                    padding: EdgeInsets.zero,
                    onPressed: () => _showClubPicker(context),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: CupertinoColors.systemGrey4),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedClub ?? 'Select Club',
                            style: TextStyle(
                              color: selectedClub == null 
                                ? CupertinoColors.systemGrey 
                                : CupertinoColors.black,
                              fontSize: 19,
                            ),
                          ),
                          const Icon(CupertinoIcons.chevron_down, color: CupertinoColors.systemGrey),
                        ],
                      ),
                    ),
                    
                  )
                else
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
                        clubSelectionError =
                            null; // Clear error when a club is selected
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
                            pageBuilder: (context, animation,
                                    secondaryAnimation) =>
                                RequestBusDetailsPage(
                                    selectedClub:
                                        selectedClub!), // Pass the selected club
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(1.0, 0.0);
                              const end = Offset.zero;
                              const curve = Curves.easeInOut;

                              var tween = Tween(begin: begin, end: end)
                                  .chain(CurveTween(curve: curve));
                              var fadeTween =
                                  Tween<double>(begin: 0.0, end: 1.0);

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
                icon: const Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
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