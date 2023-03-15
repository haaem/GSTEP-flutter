import 'package:flutter/material.dart';
import '../../config/theme/text/title_text.dart';
import 'package:dotted_line/dotted_line.dart';

class MissionRecord extends StatefulWidget {
  const MissionRecord({Key? key, required this.date, this.imagePath = 'assets/images/tree_imsi.png'}) : super(key: key);
  final String date;
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
            DottedLine(
              direction: Axis.vertical,
              lineLength: 165,
            ),
            SizedBox(width: 35,),
            Image.asset('assets/images/tree_imsi.png', height: 120,)
          ],
        )
      ],
    );
  }
}
