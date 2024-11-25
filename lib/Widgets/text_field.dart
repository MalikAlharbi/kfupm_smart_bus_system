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
          const SizedBox(height: 30), // Added spacing between Text and TextField
          Container(
            height: 40, // Increased height for better visibility
            color: Colors.white,

            child: TextField(
              style: const TextStyle(
                fontSize: 16,
              ),
              cursorHeight: 20,
              decoration: InputDecoration(
                labelText: widget.title,
                labelStyle: const TextStyle(
                  color: Colors.green,
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
                floatingLabelBehavior: FloatingLabelBehavior.always,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                border: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gapPadding: 8,
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gapPadding: 8,
                ),
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green, width: 2),
                  borderRadius: BorderRadius.all(Radius.circular(8)),
                  gapPadding: 8,
                ),
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
