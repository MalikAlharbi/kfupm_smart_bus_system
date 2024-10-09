import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';

class ReportProblemScreen extends StatefulWidget {
  @override
  _ReportProblemScreenState createState() => _ReportProblemScreenState();
}

class _ReportProblemScreenState extends State<ReportProblemScreen> {
  String _selectedProblemType = 'Non-Technical Problem';
  TextEditingController _busNumberController = TextEditingController();
  TextEditingController _problemDescriptionController = TextEditingController();
  bool isVisible = true;
  bool CameraVisible = false;
  File? image;

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
    return SafeArea(
      minimum: const EdgeInsets.all(5),
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: TopAppBar(),
        ),
        bottomNavigationBar: const BottomBar(),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.green,
                ),
                child: const Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          'Report Problem',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                elevation: 8,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Problem Type',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      DropdownButtonFormField<String>(
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          contentPadding:
                              EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        ),
                        value: _selectedProblemType,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedProblemType = newValue!;
                            isVisible =
                                newValue == "Technical Problem" ? false : true;
                            changedState(isVisible);
                          });
                        },
                        items: <String>[
                          'Non-Technical Problem',
                          'Technical Problem'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16),
              ElevatedButton.icon(
                icon: const Icon(
                  Icons.camera_alt,
                  color: Colors.black,
                ),
                label: const Text(
                  'Provide Screenshot',
                  style: TextStyle(color: Colors.white, fontSize: 22),
                ),
                onPressed: () {
                  // Implement screenshot functionality
                  pickImage();
                  CameraVisible = true;
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(vertical: 12),
                ),
              ),
              // const SizedBox(height: 16),

              Visibility(
                visible: CameraVisible,
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

              Visibility(
                visible: isVisible,
                child: TextField(
                  controller: _busNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Bus Number',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.directions_bus),
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),

              SizedBox(height: 16),
              TextField(
                controller: _problemDescriptionController,
                decoration: const InputDecoration(
                  labelText: 'Explain the Problem',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
                maxLines: 5,
              ),
              SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  // Implement submit functionality
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text(
                  'Submit',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
