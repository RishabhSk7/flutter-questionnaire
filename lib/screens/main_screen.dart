import 'package:flutter/material.dart';
import 'demographic_page.dart'; // Import Demographic Page
import 'emotion_questionnaire_page.dart'; // Import Emotion Questionnaire Page
import 'story_questionnaire_page.dart'; // Import Story Questionnaire Page
import 'admin_page.dart'; // Import Admin Page

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Questionnaire App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DemographicPage()),
                );
              },
              child: Text('Start Questionnaire'),
            ),
            SizedBox(height: 20), // Spacer
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminPage()),
                );
              },
              child: Text('Admin Panel'),
            ),
          ],
        ),
      ),
    );
  }
}
