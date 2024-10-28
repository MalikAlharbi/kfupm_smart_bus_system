import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Screens/report_problem_screen.dart';
import 'package:kfupm_smart_bus_system/Widgets/Welcoming.dart';
import 'package:kfupm_smart_bus_system/main_screen/bottom_bar.dart';
import 'package:kfupm_smart_bus_system/main_screen/top_app_bar.dart';
import 'package:kfupm_smart_bus_system/screens/contact_us.dart';

class Widgetmain extends StatelessWidget {
  const Widgetmain({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color(0xFF179C3D),
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: SafeArea(
        minimum: const EdgeInsets.all(5),
        child: Scaffold(
          appBar: AppBar(
            flexibleSpace: TopAppBar(),
          ),
          bottomNavigationBar: BottomBar(),
          body: SafeArea(
            child: Column(
              children: [
                _buildMainContent(context),
              ],
            ),
          ),
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

  Widget _buildMainContent(BuildContext context) {
    //added flexable widget, and set flexable fit to tight.
    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        margin: const EdgeInsets.all(11.0),
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
            children: [
              const Welcoming(),
              _buildGridSection(
                [
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (ctx) => // track a bus page,
                      //   ),
                      // );
                    },
                    child: _buildGridItem("Track Buses", Icons.directions_bus),
                  ),
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (ctx) => // available events page,
                      //   ),
                      // );
                    },
                    child: _buildGridItem("Available Events", Icons.event),
                  )
                ],
              ),
              const SizedBox(height: 24),
              _buildGridSection(
                [
                  InkWell(
                    onTap: () {
                      // Navigator.of(context).push(
                      //   MaterialPageRoute(
                      //     builder: (ctx) => // feedback Page,
                      //   ),
                      // );
                    },
                    child: _buildGridItem("Feedback", Icons.feedback),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (ctx) => ReportProblemScreen(),
                        ),
                      );
                    },
                    child:
                        _buildGridItem("Report Problem", Icons.report_problem),
                  ),
                ],
              ),
              const SizedBox(height: 24),
            ],
          ),
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
      children: children,
    );
  }

  Widget _buildGridItem(String title, IconData icon) {
    return Container(
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
    );
  }
}
