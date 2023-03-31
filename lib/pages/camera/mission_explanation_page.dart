import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/config/theme/text/title_text.dart';
import '../../config/theme/color.dart';
import 'package:get/get.dart';

class MissionExplanationPage extends StatefulWidget {
  const MissionExplanationPage({Key? key}) : super(key: key);

  @override
  State<MissionExplanationPage> createState() => _MissionExplanationPageState();
}

class _MissionExplanationPageState extends State<MissionExplanationPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 25, left: 25, right: 25, bottom: 45),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IconButton(
                    onPressed: () {
                      Get.toNamed('/main');
                    },
                    icon: Icon(Icons.arrow_back_rounded, color: primaryGrey, size: 30,)
                ),
                SizedBox(height: 30,),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    TitleText(
                      text: 'USE\nYOUR\nTUMBLER',
                      color: Color(0xff86A68A),
                      size: 32,
                      weight: FontWeight.w700,
                    )
                  ],
                ),
                SizedBox(height: 40,),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width - 300,
                    height: 1,
                    decoration: BoxDecoration(
                      color: primaryGrey
                    ),
                  ),
                ),
                SizedBox(height: 40,),
                Center(
                  child: Column(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width-150,
                        child: BodyText(
                          text: 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,'
                              'when an unknown printer took a galley of type and scrambled it to'
                              'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s,'
                              'when an unknown printer took a galley of type and scrambled it to',
                          color: primaryGrey,
                          size: 20,
                          weight: FontWeight.w300,
                        ),
                      ),
                      SizedBox(height: 50,),
                      Row(
                        children: [
                          SizedBox(width: 40,),
                          Icon(Icons.check_circle_outline_rounded, color: Color(0xff86A68A), size: 30,),
                          SizedBox(width: 5,),
                          Container(
                            width: MediaQuery.of(context).size.width - 190,
                            child: BodyText(text: '미션미션미션미션미션미션미션미션미션미션미션미션미션미', size: 20, color: primaryGrey, weight: FontWeight.w300,),
                          )
                        ],
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width-110,
                          height: 45,
                          decoration: BoxDecoration(
                            color: Color(0xff86A68A),
                            borderRadius: BorderRadius.circular(5)
                          ),
                          child: Center(
                            child: BodyText(text: 'Next', size: 22, weight: FontWeight.w700, color: Colors.white,),
                          ),
                        ),
                        onTap: () {

                        },
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        )
      ),
    );
  }
}
