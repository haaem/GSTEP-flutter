import 'package:flutter/material.dart';
import 'package:twentyone_days/tflite/recognition.dart';
import 'package:twentyone_days/config/theme/color.dart';

/// Individual bounding box
class BoxWidget extends StatelessWidget {
  final Recognition result;

  const BoxWidget({Key? key, required this.result}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // Color for bounding box
    Color color = primaryGrey;

    return Positioned(
      left: result.renderLocation.left,
      top: result.renderLocation.top,
      width: result.renderLocation.width,
      height: result.renderLocation.height,
      child: Container(
        width: result.renderLocation.width,
        height: result.renderLocation.height,
        decoration: BoxDecoration(
            border: Border.all(color: color, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(2))),
        child: Align(
          alignment: Alignment.topLeft,
          child: FittedBox(
            child: Container(
              color: color,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(result.label??''),
                  //Text(" ${result.score!.toStringAsFixed(2)}"),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
