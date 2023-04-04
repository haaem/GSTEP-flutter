import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/config/theme/text/title_text.dart';
import '../../config/theme/color.dart';
import 'package:get/get.dart';

class MissionExplanationPage extends StatefulWidget {
  final String missionId;
  const MissionExplanationPage({Key? key, required this.missionId}) : super(key: key);

  @override
  State<MissionExplanationPage> createState() => _MissionExplanationPageState();
}

class _MissionExplanationPageState extends State<MissionExplanationPage> {

  String? _title;
  String? _explanation;
  String? _mission;

  @override
  void initState() {
    super.initState();
    loadDecription();
  }

  void loadDecription() {
    if (widget.missionId == '1') {
      _title = 'USE\nYOUR\nTUMBLER';
      _explanation = 'Disposable plastic cups are a common item used in our daily lives, but they have a significant negative impact on the environment. These cups contribute to plastic waste pollution, which can take hundreds of years to decompose, and harm marine life and ecosystems. To reduce our environmental impact, we can use a tumbler instead of disposable plastic cups. Tumblers are reusable and made from materials like stainless steel or glass, which are eco-friendly and can be used multiple times. By using a tumbler, we can reduce the amount of plastic waste generated and minimize our carbon footprint.';
      _mission = 'USE YOUR TUMBLER';
    } else if (widget.missionId == '2') {
      _title = 'USE\nREUSABLE\nBAG';
      _explanation = 'Disposable plastic bags are a significant contributor to environmental pollution and harm wildlife and ecosystems. To protect the environment, we can take simple steps to reduce our usage of disposable plastic bags. One way to do this is by using reusable bags made of cloth, canvas, or other eco-friendly materials. These bags are durable, washable, and can be used multiple times, reducing the need for disposable plastic bags';
      _mission = 'USE REUSABLE BAG';
    } else if (widget.missionId == '3') {
      _title = 'WALK\nFOR A SHORT\nDISTANCE';
      _explanation = 'Walking short distances instead of driving or taking a taxi is a small but impactful action that can help protect the environment. The transportation sector is a significant contributor to greenhouse gas emissions, air pollution, and noise pollution, all of which have negative effects on both our health and the health of the planet. By choosing to walk, we can reduce our carbon footprint, improve air quality, and minimize noise pollution.';
      _mission = 'WALK FOR A SHORT DISTANCE';
    } else if (widget.missionId == '4') {
      _title = '“WE”\nHAVE TO\nDO IT';
      _explanation = 'Whether it\'s reducing our carbon footprint, conserving water, or supporting conservation efforts, every action we take to protect the environment makes a difference. It\'s up to us to start making those changes, right here and right now!';
      _mission = ' ';
    } else if (widget.missionId == '5') {
      _title = 'ECO\nDRIVING';
      _explanation = 'Eco-driving is a driving technique that focuses on reducing the environmental impact of vehicles by optimizing fuel efficiency and reducing emissions. By practicing eco-driving, we can protect the environment. Some simple eco-driving techniques include avoiding rapid acceleration and braking, maintaining a consistent speed, reducing idling time, and keeping tires properly inflated. Drive towards a more sustainable future!';
      _mission = ' ';
    } else {
      _title = 'NEW\nMISSION\nHERE';
      _explanation = 'something wrong happened';
      _mission = 'new\nmission\nhere';
    }
  }

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
                      text: _title!,
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
                          text: _explanation!,
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
                            child: BodyText(text: _mission!, size: 20, color: primaryGrey, weight: FontWeight.w300,),
                          )
                        ],
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width-110,
                          height: 45,
                          decoration: BoxDecoration( color: Color(0xff86A68A), borderRadius: BorderRadius.circular(5)),
                          child: Center(
                            child: BodyText(text: 'Next', size: 22, weight: FontWeight.w700, color: Colors.white,),
                          ),
                        ),
                        onTap: () { Get.toNamed('/main'); },
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
