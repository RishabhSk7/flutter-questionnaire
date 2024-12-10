import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:questionnairev2/core/database_helper.dart';
import 'package:questionnairev2/models/emotion_model.dart';
import 'package:questionnairev2/models/question_model.dart';
import 'package:questionnairev2/screens/admin_page.dart';
import 'package:questionnairev2/screens/demographic_page.dart';
import 'package:questionnairev2/screens/emotion_questionnaire_page.dart';
import 'package:questionnairev2/screens/story_questionnaire_page.dart';
import 'package:questionnairev2/screens/thank_you_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Permission.manageExternalStorage.request();
    return MaterialApp(
      title: 'Questionnaire App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemographicPage(), // Start with the Demographic Page
      routes: {
        '/emotions': (context) =>
            EmotionQuestionnairePage(emotions: _loadEmotions()),
        '/story': (context) => FutureBuilder<List<String>>(
              future: _loadStories(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  return StoryQuestionnairePage(stories: snapshot.data!);
                } else {
                  return const Center(child: Text('No stories available.'));
                }
              },
            ),
        '/thankyou': (context) => ThankYouPage(),
        '/admin': (context) => AdminPage(), // Route for Admin Page
      },
    );
  }
}

List<String> _loadEmotions() {
  List<String> emotions = [
    "happy",
    "sad",
    "fear",
    "anger",
    "surprise",
    "disgust"
  ];
  emotions.shuffle();
  return emotions;
}

Future<List<String>> _loadStories() {
  return DatabaseHelper.instance.getQuestions().then((questionList) {
    if (questionList.isEmpty) {
      return <String>[];
    }
    List<String> stories =
        questionList.map((q) => q['question'] as String).toList();
    stories.shuffle();
    return stories;
  });
}
