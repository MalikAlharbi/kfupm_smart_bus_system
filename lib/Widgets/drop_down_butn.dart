import 'package:flutter/material.dart';

const List<String> list = <String>['Technical Problem', 'B', 'C', 'D'];

class DropDownButn extends StatefulWidget{

  DropDownButn({super.key});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _DropDownButnState();
  }
}

class _DropDownButnState extends State<DropDownButn>{
//  String dropdownValue = 'Item 1';    

  // var items = [     
  //   'Item 1', 
  //   'Item 2', 
  //   'Item 3', 
  //   'Item 4', 
  //   'Item 5', 
  // ]; 


   String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return DropdownMenu<String>(
      width: 300,
      menuStyle: MenuStyle(
        backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
         
      
      ),
      textStyle: const TextStyle(
        color: Colors.white,
        fontSize: 23,
      ),
    
      initialSelection: list.first, 
      onSelected: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
        });
      },

      dropdownMenuEntries: list.map<DropdownMenuEntry<String>>((String value) {
        return DropdownMenuEntry<String>(value: value, label: value, style: ButtonStyle(
            foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
            backgroundColor: WidgetStateProperty.all<Color>(Colors.black),
             padding: WidgetStateProperty.all<EdgeInsets>(
              EdgeInsets.symmetric(horizontal: 34, vertical: 16),
            ),
          ),);
      }).toList(),
   

inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.black,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          
        ),


    ),
    trailingIcon: const Icon(Icons.arrow_drop_down, color: Colors.white, size: 50,),
    
    );

  }
}