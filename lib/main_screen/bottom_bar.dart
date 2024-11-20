import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Screens/request_bus.dart';
import 'package:kfupm_smart_bus_system/screens/widget_main.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onItemSelected;

  const BottomBar({
    super.key,
    required this.currentIndex,
    required this.onItemSelected,
  });
  

  @override
  Widget build(context) {
    return BottomNavigationBar(
  type: BottomNavigationBarType.fixed, // Ensures consistent label display
  backgroundColor: Colors.white,
  selectedItemColor: const Color(0xFF179C3D),
  currentIndex: currentIndex,
  showSelectedLabels: true, // Ensures selected labels are shown
  showUnselectedLabels: true, // Ensures unselected labels are shown
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.new_label, size: 24),
      label: "Request",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.event, size: 24),
      label: "Events",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.directions_bus, size: 24),
      label: "Track",
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.report_problem, size: 24),
      label: "Report",
    ),
  ],
  onTap: onItemSelected,
    );

    // return Container(
    //   decoration: BoxDecoration(
    //     borderRadius: BorderRadius.circular(20),
    //     color: const Color(0xFF179C3D),
    //     boxShadow: [
    //       BoxShadow(
    //         color: Colors.black.withOpacity(0.1),
    //         blurRadius: 8,
    //         offset: const Offset(0, 2),
    //       ),
    //     ],
    //   ),
    //   child: Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    //     child: Row(
    //       children: [
    //         _buildIconButton(Icons.directions_bus, () {
    //           Navigator.of(context).pushReplacement(
    //             MaterialPageRoute(
    //               builder: (ctx) => const RequestBus(),
    //             ),
    //           );
    //         }),
    //         const Spacer(),
    //         _buildIconButton(Icons.home, () {
    //           Navigator.of(context).pushReplacement(
    //             MaterialPageRoute(
    //               builder: (ctx) => const Widgetmain(),
    //             ),
    //           );
    //         }),
    //         const Spacer(),
    //         _buildIconButton(Icons.logout, () {
    //           Navigator.of(context).pop();
    //         }),
    //       ],
    //     ),
    //   ),
    // );
  }
}
