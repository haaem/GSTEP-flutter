import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';

class ColorSetting extends StatefulWidget {
  const ColorSetting({Key? key}) : super(key: key);

  @override
  State<ColorSetting> createState() => _ColorSettingState();
}

class _ColorSettingState extends State<ColorSetting> {
  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    );

    return SafeArea(
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  height: 320,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 35, right: 35, top: 35),
                  decoration: BoxDecoration(
                    borderRadius: radius,
                    color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(text: 'Select Your Color Theme', size: 16, color: Color(0xff686868), weight: FontWeight.w700,),
                      SizedBox(height: 45,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: CircleAvatar(radius: 32, backgroundColor: primaryLightGreen,),
                            onTap: () {
                              setState(() {
                                backgroundColor = primaryLightGreen;
                                buttonColor = primaryGreenButton;
                              });
                            },
                          ),
                          GestureDetector(
                            child: CircleAvatar(radius: 32, backgroundColor: primaryPink,),
                            onTap: () {
                              setState(() {
                                backgroundColor = primaryPink;
                                buttonColor = primaryPinkButton;
                              });
                            },
                          ),
                          GestureDetector(
                            child: CircleAvatar(radius: 32, backgroundColor: primaryYellow,),
                            onTap: () {
                              setState(() {
                                backgroundColor = primaryYellow;
                                buttonColor = primaryYellowButton;
                              });
                            },
                          ),
                          GestureDetector(
                            child: CircleAvatar(radius: 32, backgroundColor: primarySkyBlue,),
                            onTap: () {
                              setState(() {
                                backgroundColor = primarySkyBlue;
                                buttonColor = primarySkyBlueButton;
                              });
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width-70,
                          height: 60,
                          decoration: BoxDecoration(
                            color: buttonColor,
                            borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: BodyText(
                              text: 'Next',
                              color: Colors.white,
                              size: 18,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                        onTap: () {
                          Get.toNamed('/tree_setting');
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ),
    );
  }
}
