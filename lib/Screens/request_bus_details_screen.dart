import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class RequestBusDetailsPage extends StatefulWidget {
  const RequestBusDetailsPage({super.key});

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

  int requestCounter = 4; // Counter to generate new request numbers

  // Mutable list to store old requests
  final List<Map<String, String>> oldRequests = [
    {
      'requestNumber': 'REQ001',
      'status': 'In Process',
      'date': '2024-11-23',
      'time': '10:00 AM',
      'destination': 'Photography Club Event',
      'numberOfBuses': '2',
      'assemblyLocation': 'Main Gate',
      'reason': 'Club Meeting'
    },
    {
      'requestNumber': 'REQ002',
      'status': 'Approved',
      'date': '2024-11-20',
      'time': '1:00 PM',
      'destination': 'Robotics Competition',
      'numberOfBuses': '3',
      'assemblyLocation': 'Building 5',
      'reason': 'Competition'
    },
    {
      'requestNumber': 'REQ003',
      'status': 'Rejected',
      'date': '2024-11-15',
      'time': '3:30 PM',
      'destination': 'Art Exhibition',
      'numberOfBuses': '1',
      'assemblyLocation': 'Auditorium',
      'reason': 'Art Display'
    },
  ];

  // Error messages for validation
  String? destinationError;
  String? busesError;
  String? assemblyError;
  String? reasonError;
  String? dateError;
  String? timeError;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);

    // // Initialize date and time controllers with current values
    // dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    // timeController.text = DateFormat.jm().format(DateTime.now());
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
        title: const Text(
          'Bus Request Details',
          style: TextStyle(color: Colors.white),
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
    final sortedRequests = [
      ...oldRequests.where((req) => req['status'] == 'In Process'),
      ...oldRequests.where((req) => req['status'] == 'Approved'),
      ...oldRequests.where((req) => req['status'] == 'Rejected'),
    ];

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
                    'Reason: ${request['reason']}\n',
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
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  validateAndSubmit(context);
                },
                icon: const Icon(Icons.send),
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

  // Build Text Fields with Validation
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

  // Validation and Submission
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

    // If all validations pass
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
            borderRadius: BorderRadius.circular(16), // Rounded corners
          ),
          child: Container(
            padding: const EdgeInsets.all(20), // Add some padding
            decoration: BoxDecoration(
              color: Colors.white, // Dialog background color
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Success Icon
                Container(
                  decoration: BoxDecoration(
                    color: Colors
                        .green[100], // Light green background for the icon
                    shape: BoxShape.circle,
                  ),
                  padding: const EdgeInsets.all(16),
                  child: Icon(
                    Icons.check_circle,
                    size: 72,
                    color: Colors.green[700], // Darker green for the icon
                  ),
                ),
                const SizedBox(height: 16), // Add spacing
                // Title
                const Text(
                  'Request Sent',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87, // Dark text color
                  ),
                ),
                const SizedBox(height: 8),
                // Subtitle
                const Text(
                  'Your request has been submitted successfully.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54, // Subtle text color
                  ),
                ),
                const SizedBox(height: 24),
                // Action Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                    setState(() {
                      oldRequests.add({
                        'requestNumber':
                            'REQ${requestCounter.toString().padLeft(3, '0')}',
                        'status': 'In Process',
                        'date': dateController.text,
                        'time': timeController.text,
                        'destination': destinationController.text,
                        'numberOfBuses': busesController.text,
                        'assemblyLocation': assemblyController.text,
                        'reason': reasonController.text,
                      });
                      requestCounter++;
                      dateController.text =
                          DateFormat('yyyy-MM-dd').format(DateTime.now());
                      timeController.text =
                          DateFormat.jm().format(DateTime.now());
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
                      borderRadius: BorderRadius.circular(8), // Rounded button
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
      BuildContext context, String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        readOnly: true,
        decoration: InputDecoration(
          labelText: label,
          errorText: dateError, // Show error text for date
          labelStyle: const TextStyle(fontSize: 19),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: const Icon(Icons.calendar_today),
        ),
        onTap: () async {
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
          errorText: timeError, // Show error text for time
          labelStyle: const TextStyle(fontSize: 19),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          prefixIcon: const Icon(Icons.access_time),
        ),
        onTap: () async {
          TimeOfDay? pickedTime = await showTimePicker(
            context: context,
            initialTime: TimeOfDay.now(),
          );
          if (pickedTime != null) {
            setState(() {
              controller.text = pickedTime.format(context);
            });
          }
        },
      ),
    );
  }
}
