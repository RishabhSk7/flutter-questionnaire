import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:questionnairev2/models/emotion_model.dart';
import 'package:questionnairev2/models/question_model.dart';

class User {
  final String name;
  final int age;
  final String gender;
  final String education;
  final bool autismSpectrum;
  List<Emotion> emotions;
  List<Question> questions;

  User({
    required this.name,
    required this.age,
    required this.education,
    required this.gender,
    required this.autismSpectrum,
    List<Emotion>? emotions,
    List<Question>? questions,
  })  : emotions = emotions ?? [],
        questions = questions ?? [];

  Future<void> saveToFile() async {
    // Request storage permissions (if needed)
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      // Get the Downloads directory
      final directory = await getExternalStorageDirectory();
      if (directory != null) {
        // Create the userResponses folder in Downloads
        final userResponsesDirectory =
            Directory('/storage/emulated/0/Downloads/questionnaire');
        if (!await userResponsesDirectory.exists()) {
          await userResponsesDirectory.create(recursive: true);
        }

        // Define the file path using the user's name
        final file = File(
            '${userResponsesDirectory.path}/${name}_response_${DateTime.now().millisecondsSinceEpoch}.json');

        // Convert the User object to JSON
        String jsonString = jsonEncode(this.toJson());

        // Write the JSON string to the file
        await file.writeAsString(jsonString);
        // print('User response saved to: ${file.path}');
      } else {
        // print('Downloads directory not found.');
      }
    } else {
      // print('Permission denied');
    }
  }

  // Convert User object to JSON format
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'gender': gender,
      'autismSpectrum': autismSpectrum,
      'education': education,
      'emotions': emotions.map((e) => e.toJson()).toList(),
      'questions': questions.map((q) => q.toJson()).toList(),
    };
  }
}
