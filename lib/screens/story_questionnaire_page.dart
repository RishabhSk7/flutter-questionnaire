import 'package:flutter/material.dart';
import 'package:questionnairev2/screens/thank_you_page.dart';

class StoryQuestionnairePage extends StatefulWidget {
  @override
  _StoryQuestionnairePageState createState() => _StoryQuestionnairePageState();
}

class _StoryQuestionnairePageState extends State<StoryQuestionnairePage> {
  final List<String> stories = [
    "Someone is looking at you and smiling",
    // Add more stories as needed
  ];
  String? selectedStory;
  String? selectedEmotion;
  double intensity = 1.0;
  String? positivity;
  Offset? clickedPosition;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Story Questionnaire'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              hint: Text('Select Story'),
              value: selectedStory,
              onChanged: (value) {
                setState(() {
                  selectedStory = value;
                });
              },
              items: stories.map((String story) {
                return DropdownMenuItem<String>(
                  value: story,
                  child: Text(story),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTapDown: (details) {
                setState(() {
                  clickedPosition = details.localPosition;
                });
                // Save clicked position to a file or state as needed
              },
              child: Container(
                width: 400,
                height: 404,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black),
                ),
                child: Center(
                  child: clickedPosition != null
                      ? Icon(Icons.circle,
                          size: 30, color: Colors.red) // Show where clicked
                      : Text('Click on the body image'),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('What emotion do you feel?'),
            DropdownButton<String>(
              hint: Text('Select Emotion'),
              value: selectedEmotion,
              onChanged: (value) {
                setState(() {
                  selectedEmotion = value;
                });
              },
              items: [
                "Happy",
                "Sad",
                "Angry",
                "Surprised",
                "Disgusted",
                "Fearful"
              ].map((String emotion) {
                return DropdownMenuItem<String>(
                  value: emotion,
                  child: Text(emotion),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Text('How intensely do you feel the emotion?'),
            Slider(
              value: intensity,
              min: 1,
              max: 5,
              divisions: 4,
              label: intensity.round().toString(),
              onChanged: (double value) {
                setState(() {
                  intensity = value;
                });
              },
            ),
            SizedBox(height: 20),
            Text('Is the emotion positive or negative?'),
            DropdownButton<String>(
              hint: Text('Select'),
              value: positivity,
              onChanged: (value) {
                setState(() {
                  positivity = value;
                });
              },
              items: ["Positive", "Negative"].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    // Navigate back to the previous page
                    Navigator.pop(context);
                  },
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Proceed to the next page (Thank You Page)
                    print('Story: $selectedStory');
                    print('Clicked Position: $clickedPosition');
                    print('Emotion: $selectedEmotion');
                    print('Intensity: $intensity');
                    print('Positivity: $positivity');

                    // Here you can replace this with a thank you page
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              ThankYouPage()), // Replace with the actual page
                    );
                  },
                  child: Text('Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
