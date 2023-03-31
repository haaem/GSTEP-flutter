import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twentyone_days/config/theme/color.dart';
import 'package:twentyone_days/core/params/user.dart';
import 'package:twentyone_days/pages/camera/camera_page.dart';
import 'package:permission_handler/permission_handler.dart' as per;
import 'package:camera/camera.dart';
import '../../config/theme/text/body_text.dart';
import 'mission_record.dart';

/*
* Widgets
* - About Content (Widget): User name, current steps
* - Detect Button (GestureDetector): navigate to CameraPage
* - Mission List (Container): mission log of user
*
* Function
* - Get Camera Permission from user
* - Initialize Camera and pass to cameraPage through parameter
* - Load TFLite model and labels
*
* Todo
* - Connect Server to get data(step, mission log)
* - Load Model and label
* - Change Mission List: Container -> ListView
*
* */

class PanelWidget extends StatefulWidget {
  const PanelWidget({Key? key, required this.controller}) : super(key: key);
  final ScrollController controller;

  @override
  State<PanelWidget> createState() => _PanelWidgetState();
}

class _PanelWidgetState extends State<PanelWidget> {
  // Camera Permission Setting
  Future<bool> cameraPermission() async {
    Map<per.Permission, per.PermissionStatus> status =
      await [per.Permission.camera].request();
    if (await per.Permission.camera.isGranted) {
      return Future.value(true);
    } else {
      return Future.value(false);
    }
  }

  // Initialize available camera
  Future<CameraController> getCameraController() async {
    List<CameraDescription> cameras = await availableCameras();
    CameraController cameraController = CameraController(cameras[0], ResolutionPreset.low, enableAudio: false);
    return cameraController;
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return ListView(
      controller: widget.controller,
      children: [
        buildAboutContent(width),
        SizedBox(height: 50)
      ],
    );
  }

  Widget buildAboutContent(double width) {
    return Column(
      children: [
        SizedBox(height: 25),
        Container(height: 2, width: 90, decoration: BoxDecoration(color: primaryGrey)),
        SizedBox(height: 40),
        Container(
          margin: EdgeInsets.only(left: 35, right: 35),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BodyText(text: userName, color: primaryBlack, weight: FontWeight.w600, size: 18,),
              SizedBox(height: 17,),
              BodyText(text: 'You took 4 steps towards greener\nworld!', color: primaryGrey, size: 18,),
              SizedBox(height: 20,),
              GestureDetector(
                child: Container(
                  height: 60, width: width-70,
                  decoration: BoxDecoration( color: buttonColor, borderRadius: BorderRadius.circular(20)),
                  child: Center(child: BodyText(text: 'Detect New Step!', color: Colors.white,)),
                ),
                onTap: (() async { // initialize camera and pass the camera to cameraPage
                  var accept = await cameraPermission();
                  late var availableCamera;
                  if (accept) {
                    availableCamera = await getCameraController();
                    Navigator.push(context, MaterialPageRoute(builder: (context) => CameraPage(cameraController: availableCamera)));
                  } else {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                          content: BodyText(
                            text: 'Please set your camera permission.',
                            color: primaryBlack, size: 17, textAlign: TextAlign.start,),
                          actions: [
                            ElevatedButton(
                              onPressed: () { Get.back(); },
                              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(buttonColor)),
                              child: BodyText(
                                text: 'OK',
                                color: Colors.white, textAlign: TextAlign.center, size: 12,),
                            ),],
                        ));
                  }
                }),
              ),
              SizedBox(height: 18),
              Container(height: 2, width: width-70, decoration: BoxDecoration(color: Color(0xffCCCCCC))),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.only(left: 5, bottom: 70),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MissionRecord(date: '22 March',),
                    SizedBox(height: 8,),
                    MissionRecord(date: '18 March',),
                    SizedBox(height: 8,),
                    MissionRecord(date: '13 March',),
                    SizedBox(height: 8,),
                    MissionRecord(date: '6 March',),
                  ],
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
