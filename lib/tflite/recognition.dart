import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:twentyone_days/pages/camera/camera_view_singleton.dart';

// Represents the recognition output from the model
class Recognition {
  // Index of the result
  final int? _id;
  // Label of the result
  final String? _label;
  /// Confidence [0.0, 1.0]
  final double? _score;

  // Location of bounding box rect
  // The rectangle corresponds to the raw input image
  // passed for inference
  final Rect? _location;

  Recognition(this._id, this._label, this._score, [this._location]);

  // GETTERS
  int? get id => _id;
  String? get label => _label;
  double? get score => _score;
  Rect? get location => _location;

  // Returns bounding box rectangle corresponding to the
  // displayed image on screen
  //
  // This is the actual location where rectangle is rendered on
  // the screen
  Rect get renderLocation {
    // ratioX = screenWidth / imageInputWidth
    // ratioY = ratioX if image fits screenWidth with aspectRatio = constant

    double? ratioX = CameraViewSingleton.ratio;
    double? ratioY = ratioX;

    double transLeft = max(
      0.1,
      (location?.left ?? 0) * (ratioX ?? 0),
    );
    double transTop = max(
      0.1,
      (location?.top ?? 0) * (ratioY ?? 0),
    );
    double transWidth = min(
      (location?.width ?? 0) * (ratioX ?? 0),
      CameraViewSingleton.actualPreviewSize.width,
    );
    double transHeight = min(
      (location?.height ?? 0) * (ratioY ?? 0),
      CameraViewSingleton.actualPreviewSize.height,
    );

    Rect transformedRect =
        Rect.fromLTWH(transLeft, transTop, transWidth, transHeight);
    return transformedRect;
  }

  @override
  String toString() {
    return 'Recognition(id: $id, label: $label, score: $score, location: $location)';
  }
}