import 'package:flutter/material.dart';

class DatePickerButton extends StatefulWidget {
  const DatePickerButton({Key? key}) : super(key: key);

  @override
  _DatePickerButtonState createState() => _DatePickerButtonState();
}

class _DatePickerButtonState extends State<DatePickerButton> {
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      child: ElevatedButton(
      
        onPressed: () => _selectDate(context),
        style: ElevatedButton.styleFrom(
          
          backgroundColor: Colors.green,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Expected Date',
              style: TextStyle(color: Colors.white, fontSize: 19),
            ),
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.all(4),
              
              child: const Icon(
                Icons.date_range,
                color: Color.fromARGB(255, 1, 1, 1),
                size: 26,
              ),
            ),
          ],
        ),
      ),
    );
  }
}