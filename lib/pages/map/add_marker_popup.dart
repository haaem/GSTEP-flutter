import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twentyone_days/config/theme/tree.dart';
import 'package:twentyone_days/core/params/my_marker.dart';
import 'package:twentyone_days/pages/map/add_marker_message.dart';
import '../../config/theme/color.dart';
import '../../config/theme/text/body_text.dart';

class AddMarkerPopup extends StatelessWidget {
  const AddMarkerPopup({Key? key, required this.lat, required this.long}) : super(key: key);
  final double long;
  final double lat;

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
                        height: 55,
                      ),
                      Center(
                        child: Image.asset(
                          myTree,
                          height: 240,
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
                  height: 30,
                ),
                Row(
                  children: [
                    SizedBox(width: 30,),
                    BodyText(text: 'Once planted,\na tree cannot be moved!\nShall we plant the tree here?', size: 18, weight: FontWeight.w600, color: Color(0xff676767),)
                  ],
                ),
                SizedBox(height: 30,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(child: BodyText(text: 'Yes', color: Colors.white, size: 16, weight: FontWeight.w700,)),
                      ),
                      onTap: () {
                        markerLatitude = lat;
                        markerLongitude = long;
                        MessageAddPopup();
                      },
                    ),
                    GestureDetector(
                      child: Container(
                        width: 120,
                        height: 40,
                        decoration: BoxDecoration(
                            color: Color(0xff686868),
                            borderRadius: BorderRadius.circular(15)
                        ),
                        child: Center(child: BodyText(text: 'No', color: Colors.white, size: 16, weight: FontWeight.w700,)),
                      ),
                      onTap: () {
                        Get.back();
                      },
                    )
                  ],
                ),
                SizedBox(height: 30,)
              ],
            ),
          );
        }));
  }
}
