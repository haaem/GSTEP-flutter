import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/tflite/recognition.dart';
import 'package:twentyone_days/tflite/stats.dart';
import 'package:twentyone_days/pages/camera/box_widget.dart';
import 'package:twentyone_days/pages/camera/camera_view_singleton.dart';
import 'package:camera/camera.dart';
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
  final CameraController cameraController;
  const CameraPage({Key? key, required this.cameraController}) : super(key: key);

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {

  late CameraController controller;

  List<Recognition> results = [];

  // Stats stats = Stats(
  //     totalPredictTime: 0,
  //     inferenceTime: 0,
  //     preProcessingTime: 0,
  //     totalElapsedTime: 0);

  @override
  void initState() {
    super.initState();
    // load model
    controller = widget.cameraController;
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            break;
          default:
          // Handle other errors here.
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// Scaffold Key
  // GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
        body: Stack(
          children: <Widget>[
            // CameraView(resultsCallback, statsCallback, widget.cameraController),
            CameraView(resultsCallback, widget.cameraController),
            //CameraView(widget.cameraController),
            //boundingBoxes(results),
            // CameraPreview(controller),
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

  // return Scaffold(
  //   // key: scaffoldKey,
  //   backgroundColor: Colors.black,
  //   body: Stack(
  //     children: <Widget>[
  //       // CameraView(resultsCallback, statsCallback, widget.cameraController),
  //       // CameraView(resultsCallback, widget.cameraController),
  //       //CameraView(widget.cameraController),
  //       //boundingBoxes(results),
  //       AspectRatio(
  //       aspectRatio: widget.cameraController.value.aspectRatio,
  //           child: CameraPreview(widget.cameraController)),
  //       Align(
  //         alignment: Alignment.topLeft,
  //         child: Container(
  //           padding: EdgeInsets.only(top: 20),
  //           child: Text(
  //             'Detect New Step!',
  //             textAlign: TextAlign.left, style: TextStyle(fontSize: 18, color: primaryGrey),
  //           ),
  //         ),
  //       ),
  //     ],
  //   ),
  // );

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
}
  // Callback to get inference stats from [CameraView]
  // void statsCallback(Stats stats) {
  //   setState(() { this.stats = stats; });
  // }

  // static const BOTTOM_SHEET_RADIUS = Radius.circular(24.0);
  // static const BORDER_RADIUS_BOTTOM_SHEET = BorderRadius.only(
  //     topLeft: BOTTOM_SHEET_RADIUS, topRight: BOTTOM_SHEET_RADIUS);
// }

// /// Row for one Stats field
// class StatsRow extends StatelessWidget {
//   final String left;
//   final String right;

//   StatsRow(this.left, this.right);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [Text(left), Text(right)],
//       ),
//     );
//   }
// }


