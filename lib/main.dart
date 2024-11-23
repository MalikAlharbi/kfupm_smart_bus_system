import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/screens/kfupm_student_app.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF179C3D),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const Scaffold(body: KfupmStudentApp()),
    ),
  );
}
