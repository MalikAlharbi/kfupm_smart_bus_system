import 'dart:io';

import 'package:flutter/material.dart';

import 'package:kfupm_smart_bus_system/Widgets/drop_down_butn.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

class ReportProblemPageTwo extends StatefulWidget {
  List<String> list = <String>['Non-Technical Problem', 'Technical Problem'];
  ReportProblemPageTwo({super.key});

  @override
  State<ReportProblemPageTwo> createState() {
    // TODO: implement createState
    return _ReportProblemPageTwoState();
  }
}

class _ReportProblemPageTwoState extends State<ReportProblemPageTwo> {
  File? image;

  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;

      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (m) {
      print('Failed to pick image: $m');
    }
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;

    return Container(
      // width: 400,
      child: ListView(
        padding: EdgeInsets.all(8),
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Center(
            child: const Text(
              "Report Problem",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          DropDownButn(widget.list),

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
                onPressed: () {
                  pickImage();
                },
                onHover: (value) => (),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black, minimumSize: Size(5, 40)),
                child: const Icon(
                  Icons.camera_alt_rounded,
                  color: Colors.white,
                  size: 30,
                ),
              )
              // CameraButtonHover()
            ],
          ),

          image != null
              ? Image.file(
                  image!,
                  width: 160,
                  height: 160,
                  fit: BoxFit.cover,
                )
              : const SizedBox(
                  height: 20,
                ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Provide Bus Number",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                width: 40,
              ),
              SizedBox(
                width: 100,
                height: 50,
                child: Padding(
                  padding: const EdgeInsets.all(1.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      FilteringTextInputFormatter
                          .digitsOnly, // This line restricts input to digits only
                    ],
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      // hintText: 'Enter a search term',
                    ),
                  ),
                ),
              )
            ],
          ),

          // const Text("A screen Shot button"),
          const SizedBox(
            height: 30,
          ),

          const Center(
            child: Text(
              "Explain the Problem",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          // const Text("A TextField for Writing the Problem"),
          SizedBox(
            width: 200,
            child: TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 22.0, horizontal: 8.0),
                ),
                maxLines: 5,
                minLines: 5),
          ),

          const SizedBox(
            height: 20,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 70, right: 70),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF179C3D),
                  minimumSize: Size(1, 50)),
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          if (isKeyboard)
            SizedBox(
              height: 200,
            ),
          // Spacer()
        ],
      ),
    );
    // );
  }
}
