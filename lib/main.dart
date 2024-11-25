import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/screens/kfupm_student_app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
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
