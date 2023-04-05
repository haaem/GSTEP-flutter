import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:twentyone_days/config/theme/text/title_text.dart';
import 'package:twentyone_days/config/theme/tree.dart';
import 'package:twentyone_days/core/params/user.dart';
import 'package:twentyone_days/pages/mission/mission_page.dart';
import 'package:http/http.dart' as http;

class MissionButton extends StatefulWidget {
  const MissionButton(
      {Key? key,
      required this.id,
      required this.score,
      required this.width,
      required this.height,
      required this.color,
      required this.backColor,
      required this.name,
      required this.content,
      required this.isActive})
      : super(key: key);

  final int id;
  final int score;
  final double width;
  final double height;
  final Color color;
  final Color backColor;
  final String name;
  final String content;
  final bool isActive;

  @override
  State<MissionButton> createState() => _MissionButtonState();
}

class _MissionButtonState extends State<MissionButton> {
  bool isContent = false;
  late bool _hasScore;

  @override
  Widget build(BuildContext context) {
    MissionPageState? parent =
        context.findAncestorStateOfType<MissionPageState>();
    if (widget.score == -1) {
      _hasScore = false;
    } else {
      _hasScore = true;
    }

    if (widget.isActive == true) {
      return GestureDetector(
        child: Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
              color: isContent ? widget.backColor : widget.color,
              borderRadius: BorderRadius.circular(15)),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Stack(
              children: [
                isContent
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TitleText(
                            text: "${widget.content}",
                            size: 20,
                            color: Colors.white,
                          )
                        ],
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          TitleText(
                            text: "${userMissionProgress["${widget.id}"] + 2}",
                            size: 65,
                            color: _hasScore ? Colors.white : widget.color,
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          TitleText(
                            text: "${widget.name}",
                            size: 22,
                            color: Colors.white,
                          )
                        ],
                      ),
              ],
            ),
          ),
        ),
        onTap: () {
          isContent = !isContent;
          print(isContent);
          setState(() {});
        },
        onLongPress: () async {
          if (!isContent && widget.score != -1) {
            int score = userMissionProgress['${widget.id}'];
            userMissionProgress['${widget.id}'] = score + 1;
            HapticFeedback.mediumImpact();
            final url = Uri.parse(
              'http://34.64.137.128:8080/user/${userId}',
            );
            var json = jsonEncode({"Progress": userMissionProgress});
            log('이전: ${json}');
            final res =
                await http.put(url,
                    headers: {"Content-Type": "application/json", 'Accept': 'application/json',},
                    body: json, encoding: Encoding.getByName("utf-8")
                );
            final res2 = await http.get(url);
            var userData = jsonDecode(res2.body);
            log('이후: ${userData}');
            userMissionProgress = userData['Progress'];
            userPoint = userData['Point'];
            userLevel = userData['Step'];
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
            String treeName = 'assets/images/tree_${temp}_${userLevel}.png';
            myTree = treeName;
            setState(() {});
          }
        },
      );
      // 미션 열리지 않음
    } else {
      return Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
            color: Color(0xffDFDFDF), borderRadius: BorderRadius.circular(15)),
      );
    }
  }
}
