import 'package:flutter/material.dart';
import 'package:flutter_sfsymbols/flutter_sfsymbols.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:get/get.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/pages/mission/mission_button.dart';

class MissionPage extends StatefulWidget {
  const MissionPage({Key? key}) : super(key: key);

  @override
  State<MissionPage> createState() => _MissionPageState();
}

class _MissionPageState extends State<MissionPage> {
  late double width;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;

    return SafeArea(
        child: Scaffold(
          body: Padding(
            padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(SFSymbols.arrow_left, color: primaryGrey, size: 30,),
                    onPressed: () {
                      Get.back();
                      },
                  ),
                  SizedBox(height: 15,),
                  BodyText(
                    text: 'You’ve opened 5 missions',
                    textAlign: TextAlign.center,
                    color: primaryGrey,
                  ),
                  SizedBox(height: 25,),
                  Row(
                    children: [
                      MissionButton(
                          score: 5,
                          width: (width-50)*0.5,
                          height: 240,
                          color: Colors.teal,
                          name: "USE\nA\nTUMBLER",
                          content: "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                          isActive: true
                      ),
                      SizedBox(width: 10,),
                      MissionButton(
                          score: 5,
                          width: (width-50)*0.5,
                          height: 240,
                          color: Colors.indigo,
                          name: "USE\nA\nTUMBLER",
                          content: "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                          isActive: false
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  MissionButton(
                      score: 5,
                      width: width-40,
                      height: 240,
                      color: Colors.orange,
                      name: "USE\nA\nTUMBLER",
                      content: "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                      isActive: true
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      MissionButton(
                          score: 5,
                          width: (width-50)*0.5,
                          height: 240,
                          color: Colors.redAccent,
                          name: "USE\nA\nTUMBLER",
                          content: "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ㅍHAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                          isActive: true
                      ),
                      SizedBox(width: 10,),
                      MissionButton(
                          score: 5,
                          width: (width-50)*0.5,
                          height: 240,
                          color: Colors.deepPurpleAccent,
                          name: "USE\nA\nTUMBLER",
                          content: "HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER HAPPY TUMBLER ",
                          isActive: true
                      ),
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
          )
        )
    );
  }
}
