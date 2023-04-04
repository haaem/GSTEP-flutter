import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/tree.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:get/get.dart';
import 'package:twentyone_days/core/params/user.dart';

import '../home/main_page.dart';

class TreeSetting extends StatefulWidget {
  const TreeSetting({Key? key}) : super(key: key);

  @override
  State<TreeSetting> createState() => _TreeSettingState();
}

class _TreeSettingState extends State<TreeSetting> {
  var mineTree = myTree;

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    );

    return SafeArea(
      child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              color: backgroundColor,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Image.asset(mineTree, height: 300,),
                SizedBox(height: 100,),
                Container(
                  height: 320,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.only(left: 35, right: 35, top: 35),
                  decoration: BoxDecoration(
                      borderRadius: radius,
                      color: Colors.white
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      BodyText(text: 'Select Your Tree', size: 16, color: Color(0xff686868), weight: FontWeight.w700,),
                      SizedBox(height: 45,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            child: Image.asset(tree_green_1, width: 50,),
                            onTap: () {
                              mineTree = tree_green_1;
                              treeColor = 1;
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                            child: Image.asset(tree_pink_1, width: 50,),
                            onTap: () {
                              mineTree = tree_pink_1;
                              treeColor = 2;
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                            child: Image.asset(tree_blue_1, width: 50,),
                            onTap: () {
                              mineTree = tree_blue_1;
                              treeColor = 3;
                              setState(() {});
                            },
                          ),
                          GestureDetector(
                            child: Image.asset(tree_yel_1, width: 50,),
                            onTap: () {
                              mineTree = tree_yel_1;
                              treeColor = 4;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 40,),
                      GestureDetector(
                        child: Container(
                          width: MediaQuery.of(context).size.width-70,
                          height: 60,
                          decoration: BoxDecoration(
                              color: buttonColor,
                              borderRadius: BorderRadius.circular(20)
                          ),
                          child: Center(
                            child: BodyText(
                              text: 'Next',
                              color: Colors.white,
                              size: 18,
                              weight: FontWeight.w600,
                            ),
                          ),
                        ),
                        onTap: () {
                          setState(() {
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
                          });
                          Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
                          Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()),);
                        },
                      )
                    ],
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}
