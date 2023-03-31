import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/core/params/user.dart';
import 'package:percent_indicator/percent_indicator.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({Key? key}) : super(key: key);

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  @override
  Widget build(BuildContext context) {
    late int left;
    late int right;
    late double percent;
    if (userLevel == 0) {
      left = 0;
      right = 1;
      percent = (userPoint/5);
    } else if (userLevel == 1) {
      left = 1;
      right = 2;
      percent = ((userPoint - 5)/5);
    } else if (userLevel == 2) {
      left = 2;
      right = 3;
      percent = ((userPoint - 10)/15);
    } else if (userLevel == 3) {
      left = 3;
      right = 4;
      percent = ((userPoint - 25)/35);
    } else {
      left = 3;
      right = 4;
      percent = 1;
    }

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BodyText(text: 'Step${userLevel}', color: Colors.white, size: 16, weight: FontWeight.w700,),
            BodyText(text: 'Step${userLevel+1}', color: Colors.white, size: 16, weight: FontWeight.w700,),
          ],
        ),
        SizedBox(height: 10,),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: MediaQuery.of(context).size.width - 64,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white
              ),
            ),
            Positioned(
              top: 3,
              child: LinearPercentIndicator(
                width: MediaQuery.of(context).size.width - 50,
                backgroundColor: Colors.white,
                progressColor: buttonColor,
                lineHeight: 14,
                barRadius: Radius.circular(20),
                percent: percent,
              ),
            )
          ],
        )
      ],
    );
  }
}
