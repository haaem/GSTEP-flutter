import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/config/theme/text/body_text.dart';
import 'package:twentyone_days/config/theme/tree.dart';
import 'package:twentyone_days/core/params/user.dart';
import 'package:twentyone_days/pages/home/panel_widget.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:twentyone_days/pages/map/map_page.dart';
import 'package:http/http.dart' as http;

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<bool> permission() async {
    Map<per.Permission, per.PermissionStatus> status =
        await [per.Permission.location].request(); // [] 권한배열에 권한을 작성

    if (await per.Permission.location.isGranted) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  Future<LocationData> getCurrentLocation() async {
    Location location = Location();
    final position = await location.getLocation();
    return position;
  }

  void missionSetting() async {
    final url = Uri.parse(
      'http://34.64.137.128:8080/user/${userId}/',
    );
    var response = await http.get(url);
    print(response.body);
    var userData = jsonDecode(response.body);
    userMissionProgress = userData['Progress'];
  }

  @override
  Widget build(BuildContext context) {
    BorderRadiusGeometry radius = BorderRadius.only(
      topLeft: Radius.circular(24),
      topRight: Radius.circular(24),
    );
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;
    PanelController _pc = new PanelController();
    late var current;

    return SafeArea(
        child: Scaffold(
      body: SlidingUpPanel(
        controller: _pc,
        panelBuilder: (controller) => PanelWidget(
          controller: controller,
        ),
        minHeight: 260,
        maxHeight: height,
        borderRadius: radius,
        color: Colors.white,
        // 바탕
        body: Container(
          decoration: BoxDecoration(color: backgroundColor),
          child: Stack(
            children: [
              Positioned(
                top: 20,
                left: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.map_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () async {
                    var accept = await permission();
                    if (accept) {
                      current = await getCurrentLocation();
                      Navigator.push(context, MaterialPageRoute(builder: (context) => MapPage(location: current)));
                    } else {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                                content: BodyText(
                                  text: 'Please set your location permission.',
                                  color: primaryBlack,
                                  size: 17,
                                  textAlign: TextAlign.start,
                                ),
                                actions: [
                                  ElevatedButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                buttonColor)),
                                    child: BodyText(
                                      text: 'OK',
                                      color: Colors.white,
                                      textAlign: TextAlign.center,
                                      size: 12,
                                    ),
                                  ),
                                ],
                              ));
                    }
                  },
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IconButton(
                  icon: Icon(
                    Icons.format_list_bulleted_rounded,
                    size: 28,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    missionSetting();
                    Get.toNamed('/mission');
                  },
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: 120),
                  Image.asset(
                    myTree,
                    width: 210,
                  ),
                  Center(
                      child: SizedBox(
                    height: 70,
                  )),
                ],
              ),
              Positioned(
                  bottom: 315,
                  right: 30,
                  child: GestureDetector(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: Colors.white70,
                      ),
                      child: Icon(
                        Icons.autorenew_rounded,
                        color: Colors.black54,
                      ),
                    ),
                    onTap: () {
                      Get.toNamed('/color_setting');
                    },
                  ))
            ],
          ),
        ),
      ),
    ));
  }
}
