import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:image/image.dart' as imageLib;
import 'package:twentyone_days/tflite/recognition.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:tflite_flutter_helper/tflite_flutter_helper.dart';

import 'stats.dart';


// Loading tflite model and labels from asset
// Constructor, Getters of model instance and labels are included
class Classifier {

  Interpreter? _interpreter;
  List<String>? _labels;

  static const String modelFileName = "detect.tflite";
  static const String labelFileName = "labels.txt";

  // initialize model inference related variables
  static const int inputSize = 300;
  static const double threshold = 0.5;
  static const int numResults = 10;

  int? paddingSize;

  ImageProcessor? imageProcessor;

  // Shape and Types of output tensors
  List<List<int>>? _outputShapes;
  List<TfLiteType>? _outputTypes;

  // CONSTRUCTER
  // Initiates interpreter and labels from asset
  Classifier({
    Interpreter? interpreter,
    List<String>? labels,
  }) {
    loadModel(interpreter: interpreter);
    loadLabels(labels: labels);
  }

  // Loads interpreter from asset
  void loadModel({Interpreter? interpreter}) async {
    try {
      _interpreter = interpreter ??
          await Interpreter.fromAsset(
            modelFileName,
            options: InterpreterOptions()..threads = 4,
          );

      var outputTensors = _interpreter?.getOutputTensors();
      _outputShapes = [];
      _outputTypes = [];
      outputTensors?.forEach((tensor) {
        _outputShapes?.add(tensor.shape);
        _outputTypes?.add(tensor.type);
      });
    } catch (e) {
      print("Error while creating interpreter: $e");
    }
  }

  // Load labels from assets
  void loadLabels({List<String>? labels}) async {
    try {
      _labels =
          labels ?? await FileUtil.loadLabels("assets/" + labelFileName);
    } catch (e) {
      print("Error while loading labels: $e");
    }
  }
  // PRE-PROCESSING
  TensorImage preprocess(TensorImage? inputImg) {
    paddingSize = max(inputImg?.height ?? 0, inputImg?.width ?? 0);

    imageProcessor ??= ImageProcessorBuilder()
                        .add(ResizeWithCropOrPadOp(paddingSize ?? 0, paddingSize ?? 0))
                        .add(ResizeOp(inputSize, inputSize, ResizeMethod.BILINEAR))
                        .build();
    
    inputImg = imageProcessor?.process(inputImg!);
    return inputImg!;
  }

  // Runs object detection on the input images
  Map<String, dynamic>? predict(imageLib.Image image) {
    var predictStart = DateTime.now().millisecondsSinceEpoch;
    
    if (_interpreter == null) {
      print("Interpreter not initialized");
      return null;
    }

    // IMAGE PRE-PROCESSING
    // Image -> 300*300*3 TensorImage
    var preProcessStart = DateTime.now().millisecondsSinceEpoch;

    TensorImage inputImg = TensorImage.fromImage(image);
    inputImg = preprocess(inputImg);

    var preProcessElapsedTime = DateTime.now().millisecondsSinceEpoch - preProcessStart;

    // TensorBuffers for 4-dimensions output tensors
    TensorBuffer outputLocations = TensorBufferFloat(_outputShapes![0]);
    TensorBuffer outputClasses = TensorBufferFloat(_outputShapes![1]);
    TensorBuffer outputScores = TensorBufferFloat(_outputShapes![2]);
    TensorBuffer numDetected = TensorBufferFloat(_outputShapes![3]);

    // inputs: List of inference results for multiple objects
    List<Object> inputs = [inputImg.buffer];
    Map<int, Object> outputs = {
      0: outputLocations.buffer,
      1: outputClasses.buffer,
      2: outputScores.buffer,
      3: numDetected.buffer,
    };

    // INFERENCE
    // runs inference for multiple inputs
    var inferenceStart = DateTime.now().millisecondsSinceEpoch;

    _interpreter?.runForMultipleInputs(inputs, outputs);

    var inferenceElapsedTime = DateTime.now().millisecondsSinceEpoch - inferenceStart;

    int resultsCount = min(numResults, numDetected.getIntValue(0));
    // index 0 for ??? and index 1 for others
    int labelOffset = 1;

    // BOUNDING BOX
    List<Rect> locations = BoundingBoxUtils.convert(
      tensor: outputLocations,
      valueIndex: [1, 0, 3, 2],
      boundingBoxAxis: 2,
      boundingBoxType: BoundingBoxType.BOUNDARIES,
      coordinateType: CoordinateType.RATIO,
      height: inputSize,
      width: inputSize,
    );

    // OBJECT DETECTION RESULTS
    List<Recognition> recognitions = [];

    for (int i = 0; i < resultsCount; i++) {

      var score = outputScores.getDoubleValue(i);
      var labelIndex = outputClasses.getIntValue(i) + labelOffset;
      var label = _labels?.elementAt(labelIndex);

      if (score > threshold) {
        // [locations] corresponds to the image size 300 X 300
        // inverseTransformRect transforms it our [inputImage]
        Rect? transformedRect = imageProcessor?.inverseTransformRect(
            locations[i], image.height, image.width);

        recognitions.add(
          Recognition(i, label, score, transformedRect),
        );
      }
    }

    var predictElapsedTime = DateTime.now().millisecondsSinceEpoch - predictStart;

    return {
      "recognitions": recognitions,
      "stats": Stats(
          totalPredictTime: predictElapsedTime,
          inferenceTime: inferenceElapsedTime,
          preProcessingTime: preProcessElapsedTime,
        )
    };
  }

  // GETTERS
  Interpreter? get interpreter => _interpreter;
  List<String>? get labels => _labels;

}