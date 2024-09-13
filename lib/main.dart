import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/screens/request_bus.dart';
//import 'package:kfupm_smart_bus_system/Landscape.dart';
import 'screens/widget_main.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';
// void main() {
//   runApp(const MaterialApp(home:
//   Widgetmain())

//   );
// }
// working ? 

void main() {
  runApp(MaterialApp(
    theme: ThemeData(
      primaryColor: const Color(0xFF179C3D),
      scaffoldBackgroundColor: Colors.grey[100],
    ),
    home: Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopAppBar(),
            // Widgetmain(),
            RequestBus(),
            Spacer(),
            BottomBar(),
          ],
        ),
      ),
    ),
  ));
}

// Widget _buildBottomBar() {
//   return Container(
//     margin: const EdgeInsets.all(16.0),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: const Color(0xFF179C3D),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.1),
//           blurRadius: 8,
//           offset: const Offset(0, 2),
//         ),
//       ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           _buildIconButton(Icons.directions_bus, () {
//             print("Profile tapped");
//           }),
//           const Spacer(),
//           _buildIconButton(Icons.home, () {
//             print("home");
//           }),
//           const Spacer(),
//           _buildIconButton(Icons.logout, () {
//             print("Call tapped");
//           }),
//         ],
//       ),
//     ),
//   );
// }

// Widget _buildIconButton(IconData icon, VoidCallback onTap) {
//   return InkWell(
//     onTap: onTap,
//     child: Icon(
//       icon,
//       size: 32,
//       color: Colors.white,
//     ),
//   );
// }

// Widget _buildTopBar() {
//   return Container(
//     margin: const EdgeInsets.all(5.0),
//     decoration: BoxDecoration(
//       borderRadius: BorderRadius.circular(20),
//       color: const Color(0xFF179C3D),
//       boxShadow: [
//         BoxShadow(
//           color: Colors.black.withOpacity(0.1),
//           blurRadius: 8,
//           offset: const Offset(0, 2),
//         ),
//       ],
//     ),
//     child: Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Row(
//         children: [
//           _buildIconButton(Icons.account_circle_outlined, () {
//             print("Profile tapped");
//           }),
//           const Spacer(),
//           const Image(
//             image: AssetImage("assets/images/kfupm_logo.png"),
//             width: 57,
//           ),
//           const Spacer(),
//           _buildIconButton(Icons.call, () {
//             print("Call tapped");
//           }),
//         ],
//       ),
//     ),
//   );
// }
