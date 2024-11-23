import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RequestBus extends StatefulWidget {
  const RequestBus({Key? key}) : super(key: key);

  @override
  State<RequestBus> createState() => _RequestBusState();
}

class _RequestBusState extends State<RequestBus> {
  final TextEditingController keyController = TextEditingController();
  String? selectedClub;

  final List<String> clubs = [
    'Photography Club',
    'Robotics Club',
    'Art Club',
    'Computer Club',
    'IET Club',
    'IE Club',
    'UAS2030 Club',
    'Electrical Club',
    'Toastmasters Club',
    // Add more clubs as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Dropdown for selecting club
            DropdownButtonFormField<String>(
              value: selectedClub,
              decoration: const InputDecoration(
                labelText: 'Select Club',
                labelStyle: TextStyle(
                  fontSize: 19,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                prefixIcon: Icon(Icons.group),
              ),
              items: clubs.map((club) {
                return DropdownMenuItem(
                  value: club,
                  child: Text(club, style: const TextStyle(fontSize: 19),),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  selectedClub = value;
                });
              },
            ),
            const SizedBox(height: 20),
            // TextField for entering key
            TextField(
              controller: keyController,
              decoration: const InputDecoration(
                labelText: 'Enter Key',
                labelStyle: TextStyle(
                  fontSize: 19,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                prefixIcon: Icon(Icons.vpn_key),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 30),
            // Elevated button with icon
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add validation if needed
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RequestBusDetailsPage(),
                    ),
                  );
                },
                icon: const Icon(Icons.arrow_forward),
                label: const Text('Enter'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white, // Text color set to white
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ), // Set your desired border radius
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

  // Mutable list to store old requests
  final List<Map<String, String>> oldRequests = [
    {'requestNumber': 'REQ001', 'status': 'Approved'},
    {'requestNumber': 'REQ002', 'status': 'Rejected'},
    {'requestNumber': 'REQ003', 'status': 'In Process'},
    // Add more requests as needed
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    dateController.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    timeController.text = DateFormat.jm().format(DateTime.now());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int requestCounter = 4; // Counter to generate new request numbers

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
          labelColor: Colors.white, // Selected tab text color
          unselectedLabelColor: Colors.white70, // Unselected tab text color
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

  // Function to build Old Requests List
  Widget buildOldRequests() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: oldRequests.length,
      itemBuilder: (context, index) {
        final request = oldRequests[index];
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
            leading: Icon(
              Icons.directions_bus,
              color: Colors.green[700],
            ),
            title: Text('Request Number: ${request['requestNumber']}'),
            subtitle: Text('Status: ${request['status']}'),
            trailing: Icon(
              statusIcon,
              color: iconColor,
            ),
          ),
        );
      },
    );
  }

  // Function to build the New Request Form
  Widget buildNewRequestForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 5),
            // Date Picker Field
            buildDatePickerField(context, 'Select Date', dateController),
            const SizedBox(height: 20),
            // Time Picker Field
            buildTimePickerField(context, 'Select Time', timeController),
            const SizedBox(height: 20),
            // Destination Field
            buildTextField(
              'Destination',
              destinationController,
              icon: Icons.location_on,
            ),
            // Number of Buses Field
            buildTextField(
              'Number of Buses',
              busesController,
              icon: Icons.directions_bus,
              keyboardType: TextInputType.number,
            ),
            // Assembly Location Field
            buildTextField(
              'Assembly Location',
              assemblyController,
              icon: Icons.place,
            ),
            // Reason for Event Field
            buildTextField(
              'Reason for Event',
              reasonController,
              icon: Icons.event_note,
              maxLines: 3,
            ),
            const SizedBox(height: 30),
            // Submit Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Add form validation and submission logic here

                  // Show confirmation dialog
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Request Sent'),
                      content: Icon(
                        Icons.check_circle_outline,
                        color: Colors.green[700],
                        size: 100,
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog
                            // Add the new request to the oldRequests list
                            setState(() {
                              oldRequests.add({
                                'requestNumber':
                                    'REQ${requestCounter.toString().padLeft(3, '0')}',
                                'status': 'In Process',
                              });
                              requestCounter++;
                            });
                            // Switch to 'Old Requests' tab
                            _tabController.index = 0;
                          },
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                icon: const Icon(Icons.send),
                label: const Text(
                  'Submit Request',
                  style: TextStyle(fontSize: 20),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  foregroundColor: Colors.white, // Text color set to white
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      16,
                    ), // Set your desired border radius
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Function to build a Date Picker Field with error handling
  Widget buildDatePickerField(
      BuildContext context, String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 19,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        prefixIcon: const Icon(Icons.calendar_today),
      ),
      onTap: () async {
        DateTime initialDate = DateTime.now();
        if (controller.text.isNotEmpty) {
          try {
            initialDate = DateFormat('yyyy-MM-dd').parse(controller.text);
          } catch (e) {
            // Keep initialDate as DateTime.now()
          }
        }

        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: initialDate,
          firstDate: DateTime.now(),
          lastDate: DateTime(2030),
        );
        if (pickedDate != null) {
          setState(() {
            controller.text = DateFormat('yyyy-MM-dd').format(pickedDate);
          });
        }
      },
    );
  }

  // Function to build a Time Picker Field with error handling
  Widget buildTimePickerField(
      BuildContext context, String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      readOnly: true,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(
          fontSize: 19,
        ),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        prefixIcon: const Icon(Icons.access_time),
      ),
      onTap: () async {
        TimeOfDay initialTime = TimeOfDay.now();
        if (controller.text.isNotEmpty) {
          try {
            final format = DateFormat.jm(); // 'jm' pattern for '5:08 PM'
            final dateTime = format.parse(controller.text);
            initialTime = TimeOfDay.fromDateTime(dateTime);
          } catch (e) {
            // Keep initialTime as TimeOfDay.now()
          }
        }

        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: initialTime,
        );
        if (pickedTime != null) {
          setState(() {
            controller.text = pickedTime.format(context);
          });
        }
      },
    );
  }

  // Function to build a Text Field with Icon
  Widget buildTextField(
    String label,
    TextEditingController controller, {
    IconData? icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(fontSize: 19),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          prefixIcon: icon != null ? Icon(icon) : null,
        ),
      ),
    );
  }
}
