import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/screens/contact_us.dart';

class TopAppBar extends StatelessWidget {
  TopAppBar({super.key});

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

  @override
  Widget build(context) {
    return Container(
      margin: const EdgeInsets.all(5.0),
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
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (ctx) => //screen instence,
              //   ),
              // );
            }),
            const Spacer(),
            const Image(
              image: AssetImage("assets/images/kfupm_logo.png"),
              width: 57,
            ),
            const Spacer(),
            _buildIconButton(Icons.call, () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (ctx) => const ContactUs(),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
