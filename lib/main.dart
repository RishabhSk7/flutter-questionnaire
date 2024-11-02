import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: 'Questionnaire App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DemographicPage(), // Start with the Demographic Page
      routes: {
        '/emotions': (context) =>
            EmotionQuestionnairePage(emotions: _loadEmotions()),
        '/story': (context) => StoryQuestionnairePage(),
        '/thankyou': (context) => ThankYouPage(),
        '/admin': (context) => AdminPage(), // Route for Admin Page
      },
    );
  }
}

List<Emotion> _loadEmotions() {
  return [
    Emotion(name: "Happy", questions: [
      Question(
          text: "How intense is your happiness?",
          options: ["1", "2", "3", "4", "5"]),
      // Add more questions for "Happy" here
    ]),
    Emotion(name: "Sad", questions: [
      Question(
          text: "How intense is your sadness?",
          options: ["1", "2", "3", "4", "5"]),
      // Add more questions for "Sad" here
    ]),
    // Add more emotions and their questions
  ];
}
