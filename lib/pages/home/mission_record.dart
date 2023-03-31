import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import '../../config/theme/text/title_text.dart';
import '../../config/theme/tree.dart';

class MissionRecord extends StatefulWidget {
  const MissionRecord({Key? key, required this.date, required this.step}) : super(key: key);
  final String date;
  final String step;

  @override
  State<MissionRecord> createState() => _MissionRecordState();
}

class _MissionRecordState extends State<MissionRecord> {
  @override
  Widget build(BuildContext context) {
    late String temp;
    if (treeColor == 1) {
      temp = 'green';
    } else if (treeColor == 2) {
      temp = 'pink';
    } else if (treeColor == 3) {
      temp = 'blue';
    } else {
      temp = 'yel';
    }
    String treeName = 'assets/images/tree_${temp}_${widget.step}.png';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(text: widget.date, size: 18, textAlign: TextAlign.start,),
        SizedBox(height: 5,),
        Image.asset(treeName, height: 160,),
        SizedBox(height: 10,),
        BodyText(text: 'You took ${widget.step} steps towards greener\nworld!', color: Color(0xffBDBDBD), size: 18, weight: FontWeight.w400,),
        SizedBox(height: 10,)
      ],
    );
  }
}
