import 'package:flutter/material.dart';
import 'package:riverpod/riverpod.dart';
import 'package:twentyone_days/config/theme/color.dart';

final backgroundProvider = StateNotifierProvider((ref) => BackgroundProvider(primaryLightGreen));

class BackgroundProvider extends StateNotifier {
  BackgroundProvider(super.state);

  void setColor(Color color) {
    state = color;
  }
}