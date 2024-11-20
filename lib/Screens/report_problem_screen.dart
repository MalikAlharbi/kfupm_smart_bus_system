import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/screens/events_screen.dart';
import 'package:kfupm_smart_bus_system/screens/request_bus.dart';
import 'package:kfupm_smart_bus_system/screens/track_bus.dart';

class ReportProblemScreen extends StatefulWidget {
  const ReportProblemScreen({super.key});
  @override
  State<ReportProblemScreen> createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  String _selectedProblemType = 'Non-Technical Problem';
  final TextEditingController _busNumberController = TextEditingController();
  final TextEditingController _problemDescriptionController =
      TextEditingController();
  bool isVisible = true;
  bool cameraVisible = false;
  File? image;

  int _currentIndex = 3; // Default index for the "Smart Buses" screen

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

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (m) {
      print('Failed to pick image: $m');
    }
  }

  void changedState(bool isVisible) {
    setState(() {
      isVisible = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Smart Buses',
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.green[700],
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      bottomNavigationBar:
          BottomBar(currentIndex: _currentIndex, onItemSelected: _onItemTapped),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Problem Type',
                labelStyle: TextStyle(
                  fontSize: 20,
                ),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.report_problem_outlined),
              ),
              value: _selectedProblemType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProblemType = newValue!;
                  isVisible = newValue == "Technical Problem" ? false : true;
                  changedState(isVisible);
                });
              },
              items: <String>['Non-Technical Problem', 'Technical Problem']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            const SizedBox(height: 40),
            Visibility(
              visible: isVisible,
              child: TextField(
                controller: _busNumberController,
                decoration: const InputDecoration(
                  labelText: 'Bus Number',
                  labelStyle: TextStyle(fontSize: 20),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.directions_bus),
                ),
                keyboardType: TextInputType.number,
              ),
            ),
            const SizedBox(height: 40),
            TextField(
              controller: _problemDescriptionController,
              decoration: const InputDecoration(
                labelText: 'Explain the problem',
                labelStyle: TextStyle(fontSize: 20),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.directions_bus),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: cameraVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 16, bottom: 0),
                child: image != null
                    ? Image.file(
                        image!,
                        width: 160,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.black,
              ),
              label: const Text(
                'Provide Screenshot',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              onPressed: () {
                // Implement screenshot functionality
                pickImage();
                cameraVisible = true;
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                // Implement submit functionality
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 100),
                textStyle: const TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
