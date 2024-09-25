import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class Welcoming extends StatelessWidget {
  Welcoming({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    // return Container(
    //   decoration: BoxDecoration(
    //     image: DecorationImage(
    //       image: const AssetImage('assets/images/banner1.jpg'),
    //       fit: BoxFit.cover,
    //       colorFilter: ColorFilter.mode(
    //           Colors.black.withOpacity(0.55), BlendMode.darken),
    //     ),
    //     borderRadius: BorderRadius.circular(20),
    //     color: Colors.white,
    //   ),
    //   width: 350,
    //   height: 150,
    //   child: const Center(
    //     child: Text(
    //       "Welcome {Normal User},",
    //       style: TextStyle(
    //         color: Colors.white,
    //         fontSize: 25,
    //       ),
    //     ),
    //   ),
    // );

    return Flexible(
      fit: FlexFit.tight,
      child: Container(
        //and here I have added a bottom margin to separate the pic from the buttons bellow
        margin: const EdgeInsets.only(bottom: 30),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const NetworkImage(
                'https://cpg.kfupm.edu.sa/wp-content/uploads/2017/01/banner1.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.55), BlendMode.darken),
          ),
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        width: 350,
        height: 150,
        child: const Center(
          child: Text(
            "Welcome {Normal User},",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
            ),
          ),
        ),
      ),
    );
  }
}
