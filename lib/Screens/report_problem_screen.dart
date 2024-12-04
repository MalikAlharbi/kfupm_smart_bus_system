import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
  File? image; // File to store the selected image
  String? busNumberError;
  String? problemDescriptionError;

  // Variables to hold input data for backend
  String? busNumber;
  String? problemDescription;
  File? imageFile; // Image file variable for backend

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp();
  }

  void _showSuccessDialog(BuildContext context) {
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
                  color:
                      Colors.green[100], // Light green background for the icon
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
                'Report Sent',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87, // Dark text color
                ),
              ),
              const SizedBox(height: 8),
              // Subtitle
              const Text(
                'Your report has been submitted successfully.',
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
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(27.0),
        child: Column(
          children: [
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Problem Type',
                labelStyle: TextStyle(
                  fontSize: 19,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                prefixIcon: Icon(Icons.report_problem_outlined),
              ),
              value: _selectedProblemType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedProblemType = newValue!;
                  isVisible = newValue == "Technical Problem" ? false : true;
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
            const SizedBox(height: 20),
            Visibility(
              visible: isVisible,
              child: TextField(
                controller: _busNumberController,
                decoration: InputDecoration(
                  labelText: 'Bus Number',
                  labelStyle: const TextStyle(
                    fontSize: 19,
                  ),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(16),
                    ),
                  ),
                  prefixIcon: const Icon(Icons.directions_bus),
                  errorText: busNumberError,
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(3),
                ],
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _problemDescriptionController,
              decoration: InputDecoration(
                labelText: 'Explain the problem',
                labelStyle: const TextStyle(
                  fontSize: 19,
                ),
                border: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(16),
                  ),
                ),
                prefixIcon: const Icon(Icons.description),
                errorText: problemDescriptionError,
              ),
              maxLines: 3,
              inputFormatters: [
                LengthLimitingTextInputFormatter(200),
              ],
            ),
            const SizedBox(height: 16),
            Visibility(
              visible: cameraVisible,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 16, bottom: 0),
                child: image != null
                    ? Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green, width: 4),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(
                            image!,
                            width: 160,
                            height: 160,
                            fit: BoxFit.cover,
                          ),
                        ),
                      )
                    : const SizedBox(
                        height: 0,
                      ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              icon: const Icon(
                Icons.camera_alt_outlined,
                color: Colors.black,
              ),
              label: const Text(
                'Provide an Image',
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              onPressed: () {
                pickImage();
                setState(() {
                  cameraVisible = true;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 190, 190, 190),
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _validateAndSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green[700],
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                textStyle: const TextStyle(
                  fontSize: 20,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              label: const Text(
                'Submit Report',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (pickedImage == null) return;

      final imageTemporary = File(pickedImage.path);
      setState(() {
        image = imageTemporary;
        imageFile = imageTemporary; // Assign image to the backend variable
      });
    } on PlatformException catch (m) {
      print('Failed to pick image: $m');
    }
  }

  void _validateAndSubmit() {
    setState(() {
      busNumberError = null;
      problemDescriptionError = null;

      // Validate Bus Number only for Non-Technical Problem
      if (_selectedProblemType == 'Non-Technical Problem') {
        if (_busNumberController.text.isEmpty) {
          busNumberError = 'Please enter a bus number';
        } else if (_busNumberController.text.length != 3) {
          busNumberError = 'Bus number must be exactly 3 digits';
        }
      }

      // Validate Problem Description
      if (_problemDescriptionController.text.isEmpty) {
        problemDescriptionError = 'Please explain the problem';
      } else if (_problemDescriptionController.text.length > 200) {
        problemDescriptionError =
            'Problem description must be under 200 characters';
      }

      // If no errors, submit data
      if (busNumberError == null && problemDescriptionError == null) {
        busNumber = _selectedProblemType == 'Non-Technical Problem'
            ? _busNumberController.text
            : null; // Bus number is not required for technical problems
        problemDescription = _problemDescriptionController.text;

        // Log data for backend
        print('Problem Type: $_selectedProblemType');
        print('Bus Number: ${busNumber ?? 'null'}');
        print('Problem Description: $problemDescription');
        print('Image File: ${imageFile?.path}'); // Log image path

        // Call the function to submit the report
        submitReport(_selectedProblemType, busNumber, problemDescription!)
            .then((_) {
          // Clear the text fields only after the report is submitted
          _busNumberController.clear();
          _problemDescriptionController.clear();

          // Clear the image
          image = null;
          imageFile = null;

          // Reset the camera visibility
          cameraVisible = false;

          // Show success dialog
          _showSuccessDialog(context);
        }).catchError((error) {
          // Log error or show error message
          print("Error submitting report: $error");
        });
      }
    });
  }

  Future<void> submitReport(
      String problemType, String? busNumber, String problemDescription) async {
    try {
      final reportsCollection =
          FirebaseFirestore.instance.collection('report_problem');
      final reportSnapshot = await reportsCollection.get();
      final reportCount = reportSnapshot.size;
      String documentId = "report_problem_${reportCount + 1}";

      // Debugging logs
      print('Bus Number: ${busNumber ?? 'null'}');
      print('Problem Description: $problemDescription');

      await FirebaseFirestore.instance
          .collection('report_problem')
          .doc(documentId)
          .set({
        'timestamp': FieldValue.serverTimestamp(),
        'problemType': problemType,
        'busNumber': busNumber,
        'problemDescription': problemDescription,
      });
      // Debugging logs
      print("Report submitted successfully.");
    } catch (e) {
      print("Failed to submit report: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to submit report: $e")),
      );
    }
  }
}
