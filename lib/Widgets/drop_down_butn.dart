import 'package:flutter/material.dart';

class DropDownButn extends StatefulWidget {
  DropDownButn(List<String> this.list, {super.key});

  List<String> list;

  // = <String>['Technical Problem', 'B', 'C', 'D'];

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DropDownButnState();
  }
}

class _DropDownButnState extends State<DropDownButn> {
//  String dropdownValue = 'Item 1';

  // var items = [
  //   'Item 1',
  //   'Item 2',
  //   'Item 3',
  //   'Item 4',
  //   'Item 5',
  // ];

  String dropdownValue = "Technical Problem";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: DropdownMenu<String>(
        width: 340,
        menuStyle: MenuStyle(
          backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
        ),
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 23,
        ),
        initialSelection: widget.list.first,

        // HERE IS THE PIECE OF CODE IN ORDER TO EDIT IT TO DO NAVIGATION BETWEEN PAGES
        onSelected: (String? value) {
          // This is called when the user selects an item.
          setState(() {
            dropdownValue = value!;
          });
        },
        // END OF THE PIECE OF CODE THAT IT SHOULD BE EDITIED TO DO NAVIGATION BETWEEN PAGES

        dropdownMenuEntries:
            widget.list.map<DropdownMenuEntry<String>>((String value) {
          return DropdownMenuEntry<String>(
            value: value,
            label: value,
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
              backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
              padding: WidgetStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 34, vertical: 16),
              ),
            ),
          );
        }).toList(),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.black,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        trailingIcon: const Icon(
          Icons.arrow_drop_down,
          color: Colors.white,
          size: 50,
        ),
      ),
    );
  }
}
