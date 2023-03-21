import 'package:flutter/material.dart';

import '../../config/theme/color.dart';
import '../../config/theme/text/body_text.dart';

class MarkerPopup extends StatefulWidget {
  const MarkerPopup({Key? key}) : super(key: key);

  @override
  State<MarkerPopup> createState() => _MarkerPopupState();
}

class _MarkerPopupState extends State<MarkerPopup> {
  @override
  Widget build(BuildContext context) {
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
                          'assets/images/tree_imsi.png',
                          width: 190,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Center(
                        child: BodyText(
                          text: '2023.02.10 (금)',
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
                          text: '백승연',
                          size: 16,
                          color: primaryGrey,
                          weight: FontWeight.w600,
                        ),
                        SizedBox(
                          height: 7,
                        ),
                        BodyText(
                          text: 'South Korea',
                          size: 16,
                          color: primaryGrey,
                          weight: FontWeight.w300,
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: Center(
                        child: BodyText(
                      text:
                          'Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text',
                      size: 12,
                      color: primaryGrey,
                      weight: FontWeight.w300,
                    ))),
                SizedBox(
                  height: 35,
                )
              ],
            ),
          );
        }));
  }
}
