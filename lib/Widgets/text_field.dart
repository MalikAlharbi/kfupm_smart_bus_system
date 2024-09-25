import 'package:flutter/material.dart';

class TextFieldBus extends StatefulWidget {
  const TextFieldBus({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TextFieldBus> createState() => _TextFieldBusState();
}

class _TextFieldBusState extends State<TextFieldBus> {
  late TextEditingController controller;
  String text = '';

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: 20,
              color: Color(0xFF179C3D),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8), // Added spacing between Text and TextField
          Container(
            height: 30, // Increased height for better visibility
            color: Colors.white,

            child: TextField(
              
              style: const TextStyle(fontSize: 16,),
              cursorHeight:20,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 1),
              ),
              onChanged: (value) {
                setState(() {
                  text = value;
                });
              },
            ),
          ),
        ],
      ),
    );
  }
}