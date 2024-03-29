import 'dart:io';
import 'dart:isolate';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:twentyone_days/tflite/classifier.dart';
import 'package:twentyone_days/tflite/recognition.dart';
import 'package:twentyone_days/tflite/stats.dart';
import 'package:twentyone_days/pages/camera/camera_view_singleton.dart';
import 'package:twentyone_days/utils/isolate_utils.dart';

/*
* Widgets
* - About Content (Widget): User name, current steps
* - Detect Button (GestureDetector): navigate to CameraPage
* - Mission List (Container): mission log of user
*
* Function
* - Sends each frame for inference
* - Initialize Camera and pass to cameraPage through parameter
* - Load TFLite model and labels
*
* */

class CameraView extends StatefulWidget {
  // Callback to pass results after inference to [HomeView]
  final Function(List<Recognition> recognitions) resultsCallback;
  // Callback to inference stats to [HomeView]
  final Function(Stats stats) statsCallback;

  const CameraView(this.resultsCallback, this.statsCallback);

  @override
  _CameraViewState createState() => _CameraViewState();
}

class _CameraViewState extends State<CameraView> with WidgetsBindingObserver {
  // List of available cameras
  List<CameraDescription>? cameras;
  
  CameraController? cameraController;
  bool? predicting; // true when inference is ongoing
  Classifier? classifier; // Instance of [Classifier]
  IsolateUtils? isolateUtils; // Instance of [IsolateUtils]

  double? deviceRatio;
  double? xScale;
  double yScale = 1;

  @override
  void initState() {
    super.initState();
    initStateAsync();
  }

  void initStateAsync() async {
    WidgetsBinding.instance.addObserver(this);

    // Spawn a new isolate
    isolateUtils = IsolateUtils();
    await isolateUtils?.start();

    // Camera initialization
    initializeCamera();

    // Create an instance of classifier to load model and labels
    classifier = Classifier();

    // Initially predicting = false
    predicting = false;
  }

  // Initializes the camera by setting [cameraController]
  void initializeCamera() async {
    cameras = await availableCameras();
    // cameras[0] for rear-camera
  
    cameraController =
        CameraController(cameras![0], ResolutionPreset.max, enableAudio: false);

    cameraController?.initialize().then((_) async {
      // Stream of image passed to [onLatestImageAvailable] callback
      await cameraController?.startImageStream(onLatestImageAvailable);

      // previewSize is size of each image frame captured by controller
      // 352x288 on iOS, 240p (320x240) on Android with ResolutionPreset.low
      Size? previewSize = cameraController?.value.previewSize;
      print(previewSize);

      CameraViewSingleton.inputImageSize = previewSize;
      Size screenSize = MediaQuery.of(context).size;
      print(screenSize);

      CameraViewSingleton.screenSize = screenSize;
      CameraViewSingleton.ratio = screenSize.width / (previewSize?.height ?? 0);
      print(cameraController!.value.aspectRatio);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Return empty container while the camera is not initialized
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return Container();
    }
    return SafeArea(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Colors.black54,
        child: AspectRatio(
          aspectRatio: 1 / cameraController!.value.aspectRatio,
          child: CameraPreview(cameraController!),
        ),
      ),
    );
  }

  // Callback to receive each frame [CameraImage] perform inference on it
  onLatestImageAvailable(CameraImage cameraImage) async {
    if (classifier?.interpreter != null && classifier?.labels != null) {
      // If previous inference has not completed then return
      if (predicting ?? false) {
        return;
      }
      setState(() { predicting = true; });

      var uiThreadTimeStart = DateTime.now().millisecondsSinceEpoch;

      // Data to be passed to inference isolate
      var isolateData = IsolateData(
        cameraImage, classifier?.interpreter?.address ?? 0, classifier?.labels ?? []);

      // perform inference in separate isolate
      Map<String, dynamic> inferenceResults = await inference(isolateData);

      var uiThreadInferenceElapsedTime =
          DateTime.now().millisecondsSinceEpoch - uiThreadTimeStart;

      // pass results to cameraPage
      widget.resultsCallback(inferenceResults["recognitions"]);

      // pass stats to cameraPage
      widget.statsCallback((inferenceResults["stats"] as Stats)
        ..totalElapsedTime = uiThreadInferenceElapsedTime);

      // set predicting to false to allow new frames
      setState(() { predicting = false; });
    }
  }

  // Runs inference in another isolate
  Future<Map<String, dynamic>> inference(IsolateData isolateData) async {
    ReceivePort responsePort = ReceivePort();
    isolateUtils?.sendPort?.send(isolateData..responsePort = responsePort.sendPort);
    var results = await responsePort.first;
    return results;
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        cameraController?.stopImageStream();
        break;
      case AppLifecycleState.resumed:
        if (!cameraController!.value.isStreamingImages) {
          await cameraController?.startImageStream(onLatestImageAvailable);
        }
        break;
      default:
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    cameraController?.dispose();
    super.dispose();
  }
}