import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/tflite/recognition.dart';
import 'package:twentyone_days/tflite/stats.dart';
import 'package:twentyone_days/pages/camera/box_widget.dart';
import 'package:twentyone_days/pages/camera/camera_view_singleton.dart';

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
*
* Todo
* - Server Request
* - Label management logic
* - navigate logic
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
          Align(
            alignment: Alignment.bottomCenter,
            child: DraggableScrollableSheet(
              initialChildSize: 0.4,
              minChildSize: 0.1,
              maxChildSize: 0.5,
              builder: (_, ScrollController scrollController) => Container(
                width: double.maxFinite,
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    borderRadius: BORDER_RADIUS_BOTTOM_SHEET),
                child: SingleChildScrollView(
                  controller: scrollController,
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.keyboard_arrow_up,
                            size: 48, color: Colors.orange),
                        (stats != null)
                            ? Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    StatsRow('Inference time:',
                                        '${stats?.inferenceTime} ms'),
                                    StatsRow('Total prediction time:',
                                        '${stats?.totalElapsedTime} ms'),
                                    StatsRow('Pre-processing time:',
                                        '${stats?.preProcessingTime} ms'),
                                    StatsRow('Frame',
                                        '${CameraViewSingleton.inputImageSize?.width} X ${CameraViewSingleton.inputImageSize?.height}'),
                                  ],
                                ),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
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
    setState(() {
      this.results = results;
    });
  }

  // Callback to get inference stats from [CameraView]
  void statsCallback(Stats stats) {
    setState(() { this.stats = stats; });
  }

  static const BOTTOM_SHEET_RADIUS = Radius.circular(24.0);
  static const BORDER_RADIUS_BOTTOM_SHEET = BorderRadius.only(
      topLeft: BOTTOM_SHEET_RADIUS, topRight: BOTTOM_SHEET_RADIUS);
}

/// Row for one Stats field
class StatsRow extends StatelessWidget {
  final String left;
  final String right;

  StatsRow(this.left, this.right);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(left), Text(right)],
      ),
    );
  }
}


