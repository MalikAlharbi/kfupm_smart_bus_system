import 'package:flutter/material.dart';


class CameraButtonHover extends StatefulWidget {
  @override
  _CameraButtonHoverState createState() => _CameraButtonHoverState();
}

class _CameraButtonHoverState extends State<CameraButtonHover> {
  Color _buttonColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          _buttonColor = Colors.white; // Change to white on hover
        });
      },
      onExit: (_) {
        setState(() {
          _buttonColor = Colors.black; // Change back to black when not hovering
        });
      },
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          
          backgroundColor: _buttonColor, // Use the button color from state
          foregroundColor: Colors.black, // Text color// Use the button color from state
        ),
        onPressed: () {
          // Add your button action here
        },
        child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 30,
              ),
      ),
    );
  }
}