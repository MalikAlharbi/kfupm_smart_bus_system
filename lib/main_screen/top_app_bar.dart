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
    return AppBar(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
        
      ),
      
      backgroundColor: const Color(0xFF179C3D),
      leading: Padding(
        padding: const EdgeInsets.only(
          left: 10,
        ),
        child: _buildIconButton(Icons.account_circle_outlined, () {
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (ctx) => //screen instence,
          //   ),
          // );
        }),
      ),
      centerTitle: true,
      title: const Image(
        image: AssetImage("assets/images/kfupm_logo.png"),
        width: 50,
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(
            right: 10,
          ),
          child: _buildIconButton(Icons.call, () {
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (ctx) => const ContactUs(),
              ),
            );
          }),
        ),
      ],
    );
  }
}
