import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:twentyone_days/config/theme/tree.dart';
import '../../config/theme/color.dart';
import '../../config/theme/text/body_text.dart';

class MarkerPopup extends StatefulWidget {
  const MarkerPopup({Key? key, required this.user, required this.time}) : super(key: key);
  final int user;
  final String time;

  @override
  State<MarkerPopup> createState() => _MarkerPopupState();
}

class _MarkerPopupState extends State<MarkerPopup> {
  var user = {
    "ID": 0,
    "CreatedAt": "2023-03-22T05:47:43.931112Z",
    "UpdatedAt": "2023-03-22T05:57:34.860717Z",
    "DeletedAt": null,
    "Email": "hi@yonsei.ac.kr",
    "Nickname": "unknown",
    "Image": "",
    "Country": "unknown",
    "Step": 1,
    "Marker": {
      "ID": 0,
      "CreatedAt": "0001-01-01T00:00:00Z",
      "UpdatedAt": "0001-01-01T00:00:00Z",
      "DeletedAt": null,
      "Latitude": 0,
      "Longitude": 0,
      "Message": "",
      "Address": "",
      "IconID": 0,
      "UserID": 0
    }};

  Future getUser() async {
    final userUrl = Uri.parse(
      'http://34.64.137.128:8080/user/${widget.user}/',
    );
    var res = await http.get(userUrl);
    var userInfo = jsonDecode(res.body);
    return userInfo;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser().then((value) {
      setState(() {
        user = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    var step = user['Step'];
    var treeName = 'assets/images/tree_green_${step}.png';

    return AlertDialog(
        insetPadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        content: Builder(builder: (context) {
          var height = MediaQuery.of(context).size.height;
          var width = MediaQuery.of(context).size.width;
          BorderRadiusGeometry radius = BorderRadius.only(
            topLeft: Radius.circular(40),
            topRight: Radius.circular(40),
          );

          return Container(
            width: width - 70,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: backgroundColor, borderRadius: radius),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 85,
                      ),
                      Center(
                        child: Image.asset(
                          treeName,
                          width: 190,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: BodyText(
                          text: '${widget.time}',
                          size: 18,
                          color: Colors.white,
                          weight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 27,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BodyText(
                          text: '${user["Nickname"]}',
                          size: 16,
                          color: primaryGrey,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        BodyText(
                          text: '${user["Country"]}',
                          size: 16,
                          color: primaryGrey,
                          weight: FontWeight.w300,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 50,
                ),
              ],
            ),
          );
        }));
  }
}
