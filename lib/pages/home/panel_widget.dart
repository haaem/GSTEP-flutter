import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/core/params/user.dart';

import '../../config/theme/text/body_text.dart';
import 'mission_record.dart';

class PanelWidget extends StatefulWidget {
  const PanelWidget({Key? key, required this.controller}) : super(key: key);
  final ScrollController controller;

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return ListView(
      controller: widget.controller,
      children: [
        buildAboutContent(width),
        //SizedBox(height: 20,)
      ],
    );
  }

  Widget buildAboutContent(double width) {
    return Column(
      children: [
        SizedBox(height: 25,),
        Container(
          height: 2,
          width: 90,
          decoration: BoxDecoration(
              color: primaryGrey
          ),
        ),
        SizedBox(height: 40),
        Container(
          margin: EdgeInsets.only(left: 35, right: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(text: userName, color: primaryBlack, weight: FontWeight.w600, size: 18,),
              SizedBox(height: 17,),
              BodyText(text: 'You took 4 steps towards greener\nworld!', color: primaryGrey, size: 18,),
              SizedBox(height: 20,),
              GestureDetector(
                child: Container(
                  height: 60,
                  width: width-70,
                  decoration: BoxDecoration(
                      color: buttonColor,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: Center(child: BodyText(text: 'Detect New Step!', color: Colors.white,)),
                ),
              ),
              SizedBox(height: 18,),
              Container(
                height: 2,
                width: width-70,
                decoration: BoxDecoration(
                    color: Color(0xffCCCCCC)
                ),
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 5, bottom: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MissionRecord(date: '22 March', step: '4',),
                    SizedBox(height: 8,),
                    MissionRecord(date: '18 March', step: '3',),
                    SizedBox(height: 8,),
                    MissionRecord(date: '13 March', step: '2',),
                    SizedBox(height: 8,),
                    MissionRecord(date: '6 March', step: '1',),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
