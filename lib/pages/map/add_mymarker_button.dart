import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';

class MyMarker extends StatelessWidget {
  const MyMarker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: MediaQuery.of(context).size.width-70,
        height: 60,
        decoration: BoxDecoration(
          color: buttonColor,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(child: BodyText(text: 'Plant Your Tree!', color: Colors.white, size: 18, weight: FontWeight.w700,)),
      ),
    );
  }
}
