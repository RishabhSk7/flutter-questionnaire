import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
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

  Future<void> saveToFile(BuildContext context) async {
    // Request storage permissions
    PermissionStatus status = await Permission.manageExternalStorage. request();

    if (status.isGranted) {
      try {
        // Define the Downloads directory path
        final directory =
            Directory('/storage/emulated/0/Download/questionnaire');

        // Ensure the directory exists
        if (!(await directory.exists())) {
          await directory.create(
              recursive:
                  true); // Create the Downloads directory if it doesn't exist
          // Define the file path using the user's name and timestamp for uniqueness
        }
        final file = File(
            '${directory.path}/${name}_response_${DateTime.now().millisecondsSinceEpoch}.json');

        // Convert response data to JSON and write it to the file
        String jsonString = jsonEncode(this.toJson());
        await file.writeAsString(jsonString);
        // Show a snackbar indicating the file was created
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('User response saved to: ${file.path}'),
            ),
          );
        }

        print('User response saved to: ${file.path}');
      } catch (e) {
        print('Error saving file: $e');
        rethrow;
      }
    } else {
      print('Permission denied. Unable to save file.');
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
