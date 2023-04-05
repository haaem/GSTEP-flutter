import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:get/get.dart';
import 'package:twentyone_days/config/theme/mission_color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/core/params/user.dart';
import 'package:twentyone_days/pages/mission/mission_button.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({Key? key}) : super(key: key);

  @override
  State<MissionPage> createState() => MissionPageState();
}

class MissionPageState extends State<MissionPage> {
  late double width;
  int missionOpened = userMissionProgress.length;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
      body: Container(
        margin: EdgeInsets.only(
          top: 10,
          left: 20,
          right: 20,
        ),
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
                  SizedBox(
                    width: 20,
                  ),
                  Center(
                    child: BodyText(
                      text: "You’ve opened ${missionOpened} missions",
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
                      id: 1,
                      score: userMissionProgress.containsKey("1")
                          ? userMissionProgress["1"]
                          : 0,
                      width: (width - 50) * 0.5,
                      height: 240,
                      color: missionLightGreen,
                      backColor: missionGreen,
                      name: "USE\nYOUR\nTUMBLER",
                      content: "CHOOSE\nTUMBLERS,\nREDUCE\nPLASTIC\nWASTE",
                      isActive: userMissionProgress.containsKey('1')),
                  SizedBox(
                    width: 10,
                  ),
                  MissionButton(
                      id: 2,
                      score: -1,
                      width: (width - 50) * 0.5,
                      height: 240,
                      color: missionLightBlue,
                      backColor: missionBlue,
                      name: "USE\nREUSABLE\nBAG",
                      content:
                          "SAY NO\nTO\nPLASTIC\nBAGS,\nUSE\nREUSABLE\nONES!",
                      isActive: userMissionProgress.containsKey('2')),
                ],
              ),
              SizedBox(
                height: 8,
              ),
              MissionButton(
                  id: 3,
                  score: -1,
                  width: width - 40,
                  height: 240,
                  color: missionLightOrange,
                  backColor: missionOrange,
                  name: "WALK\nFOR\nA SHORT DISTANCE",
                  content: "WALK\nSHORT DISTANCES,\nREDUCE\nCARBON FOOTPRINT",
                  isActive: userMissionProgress.containsKey('3')),
              SizedBox(
                height: 8,
              ),
              Row(
                children: [
                  MissionButton(
                      id: 4,
                      score: -1,
                      width: (width - 50) * 0.5,
                      height: 240,
                      color: missionLightPink,
                      backColor: missionPink,
                      name: "“WE”\nHAVE TO\nDO IT",
                      content:
                          "EVERY\nACTION\nWE TAKE\nMAKES\nA\nDIFF-\nERENCE",
                      isActive: userMissionProgress.containsKey('4')),
                  SizedBox(
                    width: 10,
                  ),
                  MissionButton(
                      id: 5,
                      score: userMissionProgress.containsKey("5")
                          ? userMissionProgress["5"]
                          : 0,
                      width: (width - 50) * 0.5,
                      height: 240,
                      color: missionLightYellow,
                      backColor: missionYellow,
                      name: "ECO-\nDRIVING",
                      content:
                          "ECO-\nDRIVE\nTOWARDS\nA\nMORE\nSUSTAIN\n-ABLE\nFUTURE!",
                      isActive: userMissionProgress.containsKey('5')),
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
