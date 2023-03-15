import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';

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
    return ListView(
      controller: widget.controller,
      children: [
        buildAboutContent(),
        SizedBox(height: 50,)
      ],
    );
  }

  Widget buildAboutContent() {
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
              BodyText(text: 'yuljang_', color: primaryBlack, weight: FontWeight.w600, size: 18,),
              SizedBox(height: 20,),
              BodyText(text: 'You took 4 steps towards greener\nworld!', color: primaryGrey, size: 18, shadow: true,),
              SizedBox(height: 50,),
              Container(
                height: 2,
                width: MediaQuery.of(context).size.width-70,
                decoration: BoxDecoration(
                    color: Color(0xffCCCCCC)
                ),
              ),
              SizedBox(height: 55,),
              Container(
                margin: EdgeInsets.only(left: 5, bottom: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MissionRecord(date: '8 March',),
                    SizedBox(height: 8,),
                    MissionRecord(date: '6 March',),
                    SizedBox(height: 8,),
                    MissionRecord(date: '6 March',),
                    SizedBox(height: 8,),
                    MissionRecord(date: '6 March',),
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
