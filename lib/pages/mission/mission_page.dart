import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:get/get.dart';
import 'package:twentyone_days/config/theme/mission_color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/pages/mission/mission_button.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({Key? key}) : super(key: key);

  @override
  State<MissionPage> createState() => MissionPageState();
}

class MissionPageState extends State<MissionPage> {
  late double width;
  int score = 5;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 10,left: 20, right: 20,),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(
                      SFSymbols.arrow_left,
                      color: primaryGrey,
                      size: 30,
                    ),
                    onPressed: () {
                      Get.back();
                    },
                  ),
                  SizedBox(width: 20,),
                  Center(
                    child: BodyText(
                      text: 'You’ve opened 5 missions',
                      textAlign: TextAlign.center,
                      color: primaryGrey,
                      size: 18,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  MissionButton(
                      score: score,
                      width: (width - 50) * 0.5,
                      height: 240,
                      color: missionLightGreen,
                      backColor: missionGreen,
                      name: "USE\nA\nTUMBLER",
                      content:
                          "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                      isActive: true),
                  SizedBox(
                    width: 10,
                  ),
                  MissionButton(
                      score: score,
                      width: (width - 50) * 0.5,
                      height: 240,
                      color: missionLightBlue,
                      backColor: missionBlue,
                      name: "USE\nA\nTUMBLER",
                      content:
                          "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                      isActive: false),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              MissionButton(
                  score: score,
                  width: width - 40,
                  height: 240,
                  color: missionLightOrange,
                  backColor: missionOrange,
                  name: "USE\nA\nTUMBLER",
                  content:
                      "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                  isActive: true),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  MissionButton(
                      score: score,
                      width: (width - 50) * 0.5,
                      height: 240,
                      color: missionLightPink,
                      backColor: missionPink,
                      name: "USE\nA\nTUMBLER",
                      content:
                          "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ㅍHAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                      isActive: true),
                  SizedBox(
                    width: 10,
                  ),
                  MissionButton(
                      score: score,
                      width: (width - 50) * 0.5,
                      height: 240,
                      color: missionLightYellow,
                      backColor: missionYellow,
                      name: "USE\nA\nTUMBLER",
                      content:
                          "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                      isActive: true),
                ],
              ),
              SizedBox(
                height: 10,
              )
            ],
          ),
        ),
      ),
    ));
  }
}
