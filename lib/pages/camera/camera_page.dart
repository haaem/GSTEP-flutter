import 'dart:async';
import 'dart:ffi';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/tflite/recognition.dart';
import 'package:twentyone_days/tflite/stats.dart';
import 'package:twentyone_days/pages/camera/box_widget.dart';
import 'package:twentyone_days/pages/camera/camera_view_singleton.dart';
import 'package:twentyone_days/pages/camera/mission_explanation_page.dart';
import 'package:twentyone_days/core/params/user.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'camera_view.dart';

/*
* Widgets
* - CameraView (Widget): camera stream
* - boundingBoxs (Widget): box around recognized object
*
* Function
* - Get Inference result from CameraView
* -> Announce detected object to SERVER, Send request for contents
* -> Navigate to openMissionPage
* -> if the objects have already been detected, erase from labels
* */

class CameraPage extends StatefulWidget {
  const CameraPage({super.key});

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  List<Recognition> results = [];
  Stats? stats;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: primaryGrey,
      body: Stack(
        children: <Widget>[
          CameraView(resultsCallback, statsCallback),
          boundingBoxes(results),
          Align(
            alignment: Alignment.topLeft,
            child: Container(
              padding: EdgeInsets.only(top: 20),
              child: Text(
                'Detect New Step!',
                textAlign: TextAlign.left,
                style: TextStyle(fontSize: 18, color: primaryGrey),
              ),
            ),
          ),
        ],
      )
    );
  }

  // Returns Stack of bounding boxes
  Widget boundingBoxes(List<Recognition> results) {
    if (results == null) {
      return Container();
    }
    return Stack(
      children: results
          .map((e) => BoxWidget(result: e))
          .toList(),
    );
  }

  // Callback to get inference results from [CameraView]
  void resultsCallback(List<Recognition> results) {
    // label & missionId mapping
    String missionId = labelToMissionId(results[0].label!);

    if (missionId == '1' || missionId == '2' || missionId == '3' || missionId == '4' || missionId == '5') {
      setState(() {
        this.results = results;
      });
      // terminate and send server, navigate to result page, pass detected id to next page
      detectionResult(missionId);
        return;
    } else {
      // Ignore detected object if it belongs to the mission that is already opened.
      return;
    } 
  }

  // Callback to get inference stats from [CameraView]
  void statsCallback(Stats stats) {
    setState(() { this.stats = stats; });
  }

  String labelToMissionId(String label) {
    late String tmpId;
    if (label=='bottle' || label=='wine' || label=='glass' || label=='cup') {
      // REUSABLE CONTAINER - CUP
      tmpId = '1';
    } else if (label=='backpack' || label=='handbag') {
      // BAG
      tmpId = '2';
    } else if (label=='bicycle' || label=='bus' || label=='train' ) {
      // VEHICLE - DAILY
      tmpId = '3';
    } else if (label=='person') {
      // PERSON
      tmpId = '4';
    } else if (label=='car' || label=='motocycle' || label=='boat' || label=='truck') {
      // VEHICLE - ECO
      tmpId = '5';
    } else {
      // labels that are not related to opening mission
      tmpId = '0';
    }
    if (userMissionProgress.containsKey(tmpId)) {
      // labels already detected before
      tmpId = '0';
    } 
    
    return tmpId;
  }

  Future<void> detectionResult(String missionId) async {
    String mID = missionId;

    final post_url = Uri.parse('http://34.64.137.128:8080/user/${userId}/${mID}');
    final res = await http.put(post_url, headers: { "Content-Type" : "application/json"});
    print(res.statusCode);

    final get_url = Uri.parse('http://34.64.137.128:8080/user/${userId}/');
    final res2 = await http.get(get_url);
    var userData = jsonDecode(res2.body);
    userMissionProgress = userData['Progress'];
    userPoint = userData['Point'];
    userLevel = userData['Step'];
    Timer(Duration(seconds: 1), () => {
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => MissionExplanationPage(missionId: mID)),
      )
    });
  }

  static const BOTTOM_SHEET_RADIUS = Radius.circular(24.0);
  static const BORDER_RADIUS_BOTTOM_SHEET = BorderRadius.only(
      topLeft: BOTTOM_SHEET_RADIUS, topRight: BOTTOM_SHEET_RADIUS);
}