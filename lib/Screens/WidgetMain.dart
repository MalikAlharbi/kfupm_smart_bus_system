import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Widgets/Welcoming.dart';

class Widgetmain extends StatelessWidget {
  const Widgetmain({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF179C3D),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                _buildTopBar(),
                _buildMainContent(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xFF179C3D),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            _buildIconButton(Icons.account_circle_outlined, () {
              print("Profile tapped");
            }),
            const Spacer(),
            Image.network(
              'https://upload.wikimedia.org/wikipedia/ar/archive/3/37/20180719130502%21King_Fahd_University_of_Petroleum_%26_Minerals_Logo.png',
              width: 57,
            ),
            const Spacer(),
            _buildIconButton(Icons.call, () {
              print("Call tapped");
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildIconButton(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Icon(
        icon,
        size: 32,
        color: Colors.white,
      ),
    );
  }

  Widget _buildMainContent() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: const Color(0xA30B6725),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Welcoming(),
            const SizedBox(height: 24),
            _buildGridSection(
              [
                _buildGridItem("Track Buses", Icons.directions_bus),
                _buildGridItem("Available Events", Icons.event),
              ],
            ),
            const SizedBox(height: 24),
            _buildGridSection(
              [
                _buildGridItem("Feedback", Icons.feedback),
                _buildGridItem("Report Problem", Icons.report_problem),
              ],
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildGridSection(List<Widget> children) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: children,
    );
  }

  Widget _buildGridItem(String title, IconData icon) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 48, color: const Color(0xFF179C3D)),
          const SizedBox(height: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
