import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Widgets/Welcoming.dart';
import '../Landscape.dart';
class Widgetmain extends StatelessWidget{
  Widgetmain({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
    home: Scaffold(
      body: SizedBox(
        width: double.infinity,
        
        child: Column(
          
          
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
                  Container(
                          margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                            color:  Color.fromRGBO(23,156,61,1),
                            
                        ),
                        width: 322.0,
                        height: 50.0,
                       child: Padding(
                         padding: const EdgeInsets.only(
                         left: 20,
                        
                         right: 20
                         ),
                         child: Row(
                          children: [
                         
                          //  IconButton( onPressed: (){}, icon:Icon(Icons.alarm)),
                          InkWell(
                           
                            onTap: (){print("Wokring>>");},
                            child: Icon(Icons.account_circle_outlined, size: 42,),
                          ),
                            Spacer(),
                            InkWell(
                              onTap: (){},
                            child: Image(image: NetworkImage('https://upload.wikimedia.org/wikipedia/ar/archive/3/37/20180719130502%21King_Fahd_University_of_Petroleum_%26_Minerals_Logo.png'), width: 57,),
                            ),
                            Spacer(),
                            InkWell(
                            onTap: (){},
                            child: Icon(Icons.call, size: 37,),

                         ),
                            ]
                            ,
                         ),
                       ),
                  ),





                // Main Widget in the Landscape page 
                // I need to Create a Column then
                // within the column there will be 4 widgets,
                // the first is for header 
                // the second is Grid Widget contain two widgets (Track Buses and Available Events)
                // the third widget is a Grid Widget that contains 2 widget inside the grid for feed back and problems
                // the last widget is for Contact us widget
                  Container(
                        margin: const EdgeInsets.all(10.0),
                        decoration: const BoxDecoration(
                           borderRadius: BorderRadius.all(Radius.circular(20)),
                            color:  Color.fromRGBO(11, 103, 37, 0.64),
                            
                        ),
                        width: 392.0,
                        height: 650.0,
                       child: Column(
                        children: [
                          Welcoming()
                          ,
                          
                        ],
                       ),
                          ) ,
                          
              







              
          // Landscape()
          
          ]
        
        ),
      ) ,
    ),
  );
  }
}