import 'package:flutter/material.dart';
import 'package:kfupm_smart_bus_system/Widgets/drop_down_butn.dart';

class ReportProblemPageOne extends StatelessWidget {
  List<String> list = <String>['Technical Problem', 'Non-Technical Problem'];

  ReportProblemPageOne({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Report Problem",
          style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 20,
        ),

        DropDownButn(list),

        // Text("A Drop Down Button for Choosing the Problem"),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Provide Screen Shot",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Icon(
                Icons.camera_alt_rounded,
                color: Colors.white,
                size: 30,
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, minimumSize: Size(5, 40)),
            )
          ],
        ),
        SizedBox(
          height: 20,
        ),

        // const Text("A screen Shot button"),

        SizedBox(
          height: 20,
        ),
        const Text(
          "Explain the Problem",
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        // const Text("A TextField for Writing the Problem"),
        Container(
          width: 300,
          child: TextFormField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 75.0, horizontal: 5.0),
              ),
              maxLines: 5,
              minLines: 3),
        ),

        const SizedBox(
          height: 20,
        ),

        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF179C3D),
              minimumSize: Size(120, 40)),
          child: const Text(
            "Submit",
            style: TextStyle(color: Colors.white),
          ),
        ),
        // Spacer()
      ],
    );
  }
}
