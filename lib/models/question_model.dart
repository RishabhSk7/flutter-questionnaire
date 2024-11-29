import 'package:flutter/services.dart';

class Question {
  final String storyText;
  Offset? selectedBodyPosition;
  String? selectedEmotion;
  double? intensity;
  String? emotionValence;

  Question({
    required this.storyText,
    this.selectedBodyPosition,
    this.selectedEmotion,
    this.intensity,
    this.emotionValence,
  });

  // Convert Question object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'storyText': storyText,
      'selectedBodyPosition': [
        selectedBodyPosition!.dx,
        selectedBodyPosition!.dy
      ],
      'selectedEmotion': selectedEmotion,
      'intensity': intensity,
      'emotionValence': emotionValence,
    };
  }
}
