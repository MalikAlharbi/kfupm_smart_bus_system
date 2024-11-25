import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Screens/events_screen.dart';
import 'package:kfupm_smart_bus_system/Screens/report_problem_screen.dart';
import 'package:kfupm_smart_bus_system/Screens/request_bus.dart';
import 'package:kfupm_smart_bus_system/Screens/track_bus.dart';

class MainScaffold extends StatefulWidget {
  final int currentIndex;

  const MainScaffold({
    super.key,
    this.currentIndex = 2,
  });

  @override
  _MainScaffoldState createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  late PageController _pageController;
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
    _pageController = PageController(initialPage: _currentIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  late final List<Widget> _pages = [
    const RequestBus(),
    const EventsScreen(),
    const TrackBus(),
    const ReportProblemScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: const Color(0xFF179C3D),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.new_label,
            ),
            label: 'Request',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.event,
            ),
            label: 'Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.directions_bus,
            ),
            label: 'Track',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.report_problem,
            ),
            label: 'Report',
          ),
        ],
      ),
    );
  }
}
