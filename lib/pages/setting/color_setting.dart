import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class ColorSetting extends StatefulWidget {
  const ColorSetting({Key? key}) : super(key: key);

  @override
  State<ColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<ColorSetting> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          body: SlidingUpPanel(
            //바탕
            body: Container(
              decoration: BoxDecoration(
                color: 
              ),
            ),
          ),
        )
    );
  }
}
