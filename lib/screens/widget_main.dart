import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/widgets/welcoming.dart';

class Widgetmain extends StatelessWidget {
  const Widgetmain({super.key});

  @override
  Widget build(BuildContext context) {
    return _buildMainContent();
  }

  Widget _buildMainContent() {
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Welcoming(),
             const SizedBox(height: 24),
            SizedBox(
              child: _buildGridSection(
                [
                  _buildGridItem("Track Buses", Icons.directions_bus),
                  _buildGridItem("Available Events", Icons.event),
                ],
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              child: _buildGridSection(
                [
                  _buildGridItem("Feedback", Icons.feedback),
                  _buildGridItem("Report Problem", Icons.report_problem),
                ],
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildGridSection(List<Widget> children) {
    return GridView.count(
      physics: NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      children: children,
    );
  }

  Widget _buildGridItem(String title, IconData icon) {
    return InkWell(
      onTap: () {
        print("wORKING !!!");
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(40),
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
      ),
    );
  }
}