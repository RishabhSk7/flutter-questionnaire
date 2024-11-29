import 'package:flutter/services.dart';

class Emotion {
  String? emotion;
  Offset? selectedBodyPosition;
  double? intensity;
  String? emotionValence;

  Emotion({
    this.emotion,
    this.selectedBodyPosition,
    this.intensity,
    this.emotionValence,
  });

  // Convert Emotion object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'emotion': emotion,
      'selectedBodyPosition': [
        selectedBodyPosition!.dx,
        selectedBodyPosition!.dy
      ],
      'intensity': intensity,
      'emotionValence': emotionValence,
    };
  }
}
