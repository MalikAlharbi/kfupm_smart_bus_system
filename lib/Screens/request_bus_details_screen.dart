import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RequestBusDetailsPage extends StatefulWidget {
  final String selectedClub; // Add a field for the selected club

  const RequestBusDetailsPage({super.key, required this.selectedClub});

  @override
  State<RequestBusDetailsPage> createState() => _RequestBusDetailsPageState();
}

class _RequestBusDetailsPageState extends State<RequestBusDetailsPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final TextEditingController dateController = TextEditingController();
  final TextEditingController timeController = TextEditingController();
  final TextEditingController destinationController = TextEditingController();
  final TextEditingController busesController = TextEditingController();
  final TextEditingController assemblyController = TextEditingController();
  final TextEditingController reasonController = TextEditingController();

  List<Map<String, dynamic>> oldRequests = [];

  // Error messages for validation
  String? destinationError;
  String? busesError;
  String? assemblyError;
  String? reasonError;
  String? dateError;
  String? timeError;

//List<Map<String, dynamic>> oldRequests = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    loadClubRequests();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '${widget.selectedClub} Requests',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Old Requests'),
            Tab(text: 'New Request'),
          ],
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.white,
          labelStyle: const TextStyle(fontSize: 17),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Old Requests Tab
          buildOldRequests(),
          // New Request Form Tab
          buildNewRequestForm(context),
        ],
      ),
    );
  }

  // Old Requests Tab
  Widget buildOldRequests() {
    // debug message
    print('Old requests size: ${oldRequests.length}');

    // Filter requests by the selected club
    final filteredRequests = oldRequests
        .where((req) => req['clubName'] == widget.selectedClub)
        .toList();

    // Sort filtered requests by status
    final sortedRequests = [
      ...filteredRequests.where((req) => req['status'] == 'In Process'),
      ...filteredRequests.where((req) => req['status'] == 'Approved'),
      ...filteredRequests.where((req) => req['status'] == 'Rejected'),
    ];

    if (sortedRequests.isEmpty) {
      return const Center(
        child: Text('No requests available for this club.'),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: sortedRequests.length,
      itemBuilder: (context, index) {
        final request = sortedRequests[index];
        IconData statusIcon;
        Color iconColor;

        switch (request['status']) {
          case 'Approved':
            statusIcon = Icons.check_circle;
            iconColor = Colors.green;
            break;
          case 'Rejected':
            statusIcon = Icons.cancel;
            iconColor = Colors.red;
            break;
          default:
            statusIcon = Icons.hourglass_top;
            iconColor = Colors.orange;
        }

        return Card(
          margin: const EdgeInsets.only(bottom: 16.0),
          child: ListTile(
            leading: Icon(Icons.directions_bus, color: Colors.green[700]),
            title: Text('Request Number: ${request['requestNumber']}'),
            subtitle: Text(
                'Status: ${request['status']}\nDestination: ${request['destination']}'),
            trailing: Icon(statusIcon, color: iconColor),
            onTap: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Request Details'),
                  content: Text(
                    'Request Number: ${request['requestNumber']}\n'
                    'Status: ${request['status']}\n'
                    'Date: ${request['date']}\n'
                    'Time: ${request['time']}\n'
                    'Destination: ${request['destination']}\n'
                    'Number of Buses: ${request['numberOfBuses']}\n'
                    'Assembly Location: ${request['assemblyLocation']}\n'
                    'Reason: ${request['reason']}\n'
                    'Club: ${request['clubName']}\n',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      },
    );
  }

  // New Request Form Tab
  Widget buildNewRequestForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            buildDatePickerField(context, 'Select Date', dateController),
            buildTimePickerField(context, 'Select Time', timeController),
            buildTextField(
              'Destination',
              destinationController,
              icon: Icons.location_on,
              maxLength: 50,
              errorText: destinationError,
            ),
            buildTextField(
              'Number of Buses',
              busesController,
              icon: Icons.directions_bus,
              keyboardType: TextInputType.number,
              maxLength: 2,
              errorText: busesError,
            ),
            buildTextField(
              'Assembly Location',
              assemblyController,
              icon: Icons.place,
              maxLength: 50,
              errorText: assemblyError,
            ),
            buildTextField(
              'Reason for Event',
              reasonController,
              icon: Icons.event_note,
              maxLength: 200,
              errorText: reasonError,
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  validateAndSubmit(context);
                },
                icon: const Icon(
                  Icons.send,
                  color: Colors.white,
                ),
                label: const Text('Submit Request',
                    style: TextStyle(fontSize: 20)),
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

  Widget buildTextField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLength = 50,
    int maxLines = 1,
    String? errorText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        inputFormatters: [
          LengthLimitingTextInputFormatter(maxLength),
        ],
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 19),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          errorText: errorText,
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }

  void validateAndSubmit(BuildContext context) {
    // Hide the keyboard
    FocusScope.of(context).unfocus();

    setState(() {
      destinationError = destinationController.text.isEmpty
          ? 'Please enter the destination'
          : null;
      busesError = busesController.text.isEmpty
          ? 'Please enter the number of buses'
          : null;
      assemblyError = assemblyController.text.isEmpty
          ? 'Please enter the assembly location'
          : null;
      reasonError = reasonController.text.isEmpty
          ? 'Please enter the reason for the event'
          : null;
      dateError = dateController.text.isEmpty
          ? 'Please select a date'
          : null; // Validate date
      timeError = timeController.text.isEmpty
          ? 'Please select a time'
          : null; // Validate time
    });

    if (destinationError == null &&
        busesError == null &&
        assemblyError == null &&
        reasonError == null &&
        dateController.text.isNotEmpty &&
        timeController.text.isNotEmpty) {
      showDialog(
        context: context,
        builder: (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.green[100],
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.check_circle,
                    size: 72,
                    color: Colors.green[700],
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Request Sent',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Your request has been submitted successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () async {
                    Navigator.of(context).pop();

                    await submitRequest(
                      context,
                      dateController.text,
                      timeController.text,
                      destinationController.text,
                      busesController.text,
                      assemblyController.text,
                      reasonController.text,
                      widget.selectedClub,
                    );

                    // debug message
                    print('Request submitted successfully.');

                    // Reload the requests after submission
                    await loadClubRequests();

                    setState(() {
                      // Clear the form
                      dateController.clear();
                      timeController.clear();
                      destinationController.clear();
                      busesController.clear();
                      assemblyController.clear();
                      reasonController.clear();
                      _tabController.index = 0;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green[700],
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 24),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'OK',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }

  Widget buildDatePickerField(
    BuildContext context,
    String label,
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          errorText: dateError,
          labelStyle: const TextStyle(fontSize: 19),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
          if (Platform.isIOS) {
            // iOS date picker
            DateTime? pickedDate = await showModalBottomSheet<DateTime>(
              context: context,
              builder: (BuildContext context) {
                return CupertinoDatePicker(
                  mode: CupertinoDatePickerMode.date,
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      controller.text =
                          DateFormat('yyyy-MM-dd').format(newDate);
                    });
                  },
                );
              },
            );
          } else {
            // Android date picker
            DateTime? pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime(2030),
            );
            if (pickedDate != null) {
              setState(() {
                controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
              });
            }
          }
        },
      ),
    );
  }

  Widget buildTimePickerField(
      BuildContext context, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          errorText: timeError,
          labelStyle: const TextStyle(fontSize: 19),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: const Icon(Icons.access_time),
        ),
        onTap: () async {
          // Check for iOS platform
          if (Platform.isIOS) {
            // Use a native iOS time picker
            TimeOfDay? pickedTime = await showModalBottomSheet<TimeOfDay>(
              context: context,
              builder: (BuildContext context) {
                return CupertinoTimerPicker(
                  mode: CupertinoTimerPickerMode.hm,
                  onTimerDurationChanged: (Duration newDuration) {
                    final time =
                        TimeOfDay.fromDateTime(DateTime(0).add(newDuration));
                    setState(() {
                      controller.text = time.format(context);
                    });
                  },
                );
              },
            );
          } else {
            // Use a material time picker for Android
            TimeOfDay? pickedTime = await showTimePicker(
              context: context,
              initialTime: TimeOfDay.now(),
            );
            if (pickedTime != null) {
              setState(() {
                controller.text = pickedTime.format(context);
              });
            }
          }
        },
      ),
    );
  }

// Function to submit the form data to Firebase
  Future<void> submitRequest(
    BuildContext context,
    String date,
    String time,
    String destination,
    String numberOfBuses,
    String assemblyLocation,
    String reason,
    String clubName,
  ) async {
    try {
      final requestsCollection = FirebaseFirestore.instance.collection('Event');
      final requestSnapshot = await requestsCollection.get();
      final requestCount = requestSnapshot.size;
      String documentId = "event_${requestCount + 1}";
      String requestNumber =
          "REQ${(requestCount + 1).toString().padLeft(3, '0')}";

      // Parse the date and time
      DateTime parsedDate = DateTime.parse(date); // "2024-12-26"
      DateTime parsedTime = DateFormat.jm().parse(time); // "5:03 AM"

      // Combine date and time
      DateTime combinedDateTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        parsedTime.hour,
        parsedTime.minute,
      );

      await requestsCollection.doc(documentId).set({
        'requestNumber': requestNumber,
        'status': 'In Process', // Default status
        'date': date,
        'timeOfEvent': time,
        'dateTime':
            Timestamp.fromDate(combinedDateTime), // Combined date and time
        'destination': destination,
        'numberOfBuses': numberOfBuses,
        'assemblyLocation': assemblyLocation,
        'reasonOfEvent': reason,
        'clubName': clubName,
        'timestamp': FieldValue.serverTimestamp(), // For sorting
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit request: $e")),
      );
      print("Error submitting request: $e");
    }
  }

  Future<void> loadClubRequests() async {
    try {
      final requestsCollection = FirebaseFirestore.instance.collection('Event');
      final querySnapshot = await requestsCollection
          .where('clubName', isEqualTo: widget.selectedClub)
          //.orderBy('timestamp', descending: true)
          .get();

      print('Documents retrieved: ${querySnapshot.docs.length}');
      for (var doc in querySnapshot.docs) {
        print('Document data: ${doc.data()}');
      }

      setState(() {
        oldRequests = querySnapshot.docs.map((doc) {
          final data = doc.data();
          return {
            'requestNumber': data['requestNumber'] ?? '',
            'status': data['status'] ?? '',
            'date': data['date'] ?? '',
            'time': data['timeOfEvent'] ?? '',
            'destination': data['destination'] ?? '',
            'numberOfBuses': data['numberOfBuses'] ?? '',
            'assemblyLocation': data['assemblyLocation'] ?? '',
            'reason': data['reasonOfEvent'] ?? '',
            'clubName': data['clubName'] ?? '',
          };
        }).toList();
      });
    } catch (e) {
      print("Error loading requests: $e");
    }
  }
}
