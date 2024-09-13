import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/special_buttons/special_text_field.dart';

class TextFieldBus extends StatefulWidget {
  TextFieldBus({super.key, required this.title});

  final String title;
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _TextFieldBusState();
  }
}

class _TextFieldBusState extends State<TextFieldBus> {
  @override
  Widget build(BuildContext context) {
    late TextEditingController controller;
    String text = '';

  @override 
  void initState(){
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose(){
    super.dispose();
    controller.dispose();
    
  }


    // TODO: implement build
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 300,
        height: 50,
        color: Color.fromRGBO(56, 162, 86, 1),
        child: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Row(
            children: [
              Text(
                widget.title,
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(width: 10,),

             Container(
              
              
              color: Colors.white,
              child: Text("need to be changed"),
             ),
             SizedBox(width: 10,),
            ],
          ),
        ),
      ),
    );
  }
}
