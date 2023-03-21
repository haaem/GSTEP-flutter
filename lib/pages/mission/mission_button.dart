import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/config/theme/text/title_text.dart';
import 'package:twentyone_days/pages/mission/mission_page.dart';

class MissionButton extends StatefulWidget {
  const MissionButton({
    Key? key,
    required this.score,
    required this.width,
    required this.height,
    required this.color,
    required this.name,
    required this.content,
    required this.isActive
  }) : super(key: key);

  final int score;
  final double width;
  final double height;
  final Color color;
  final String name;
  final String content;
  final bool isActive;

  @override
  State<MissionButton> createState() => _MissionButtonState();
}

class _MissionButtonState extends State<MissionButton> {
  @override
  Widget build(BuildContext context) {
    MissionPageState? parent = context.findAncestorStateOfType<MissionPageState>();

    if (widget.isActive == true) {
      return GestureDetector(
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [widget.color, widget.color.withOpacity(0.35)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(15)
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 30,),
                    TitleText(
                      text: "${parent!.score}",
                      size: 65,
                      color: Colors.white,
                    ),
                    SizedBox(height: 3,),
                    TitleText(
                      text: "${widget.name}",
                      size: 24,
                      color: Colors.white,
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
        onTap: () {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                content: Container(
                  margin: EdgeInsets.only(top: 80, bottom: 40),
                  width: MediaQuery.of(context).size.width - 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      Image.asset('assets/images/cup_garbage.png', width: 50, height: 50,),
                      SizedBox(height: 20,),
                      Container(height: 1, width: 90, decoration: BoxDecoration(color: primaryGrey),),
                      SizedBox(height: 20,),
                      BodyText(text: widget.content, color: primaryGrey,),
                    ],
                  ),
                )
              )
          );
        },
        onLongPress: () {
          parent!.setState(() {
            parent.score++;
          });
          HapticFeedback.mediumImpact();
          setState(() {});
        },
      );
      // 미션 열리지 않음
    } else {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: Color(0xffDFDFDF),
            borderRadius: BorderRadius.circular(15)
        ),
      );
    }
  }
}
