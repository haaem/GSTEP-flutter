import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import '../../config/theme/text/title_text.dart';
import 'package:dotted_line/dotted_line.dart';

class MissionRecord extends StatefulWidget {
  const MissionRecord({Key? key, required this.date, required this.step, this.imagePath = 'assets/images/tree_imsi.png'}) : super(key: key);
  final String date;
  final String step;
  final String imagePath;

  @override
  State<MissionRecord> createState() => _MissionRecordState();
}

class _MissionRecordState extends State<MissionRecord> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(text: widget.date, size: 18, textAlign: TextAlign.start,),
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 10,),
            Image.asset('assets/images/tree_imsi.png', height: 120,),
          ],
        ),
        SizedBox(height: 10,),
        BodyText(text: 'You took ${widget.step} steps towards greener\nworld!', color: Color(0xffBDBDBD), size: 18, weight: FontWeight.w400,),
        SizedBox(height: 10,)
      ],
    );
  }
}
