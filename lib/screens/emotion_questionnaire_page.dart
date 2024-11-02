import 'package:flutter/material.dart';
import 'package:questionnairev2/models/emotion_model.dart';
import 'package:questionnairev2/widgets/human_body_widget.dart';
import 'package:questionnairev2/widgets/question_widget.dart';

class EmotionQuestionnairePage extends StatefulWidget {
  final List<Emotion> emotions;

  EmotionQuestionnairePage({required this.emotions});

  @override
  _EmotionQuestionnairePageState createState() =>
      _EmotionQuestionnairePageState();
}

class _EmotionQuestionnairePageState extends State<EmotionQuestionnairePage> {
  int currentEmotionIndex = 0;

  @override
  Widget build(BuildContext context) {
    final currentEmotion = widget.emotions[currentEmotionIndex];

    return Scaffold(
      appBar: AppBar(title: Text(currentEmotion.name)),
      body: Column(
        children: [
          EmotionCard(emotion: currentEmotion.name),
          // Display questions for the current emotion
          ...currentEmotion.questions
              .map((question) => QuestionWidget(question: question))
              .toList(),
          // Navigation buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: currentEmotionIndex > 0
                    ? () {
                        setState(() {
                          currentEmotionIndex--;
                        });
                      }
                    : null,
                child: Text('Previous'),
              ),
              ElevatedButton(
                onPressed: currentEmotionIndex < widget.emotions.length - 1
                    ? () {
                        setState(() {
                          currentEmotionIndex++;
                        });
                      }
                    : () {
                        // Navigate to the story section if it's the last emotion
                        Navigator.pushNamed(context, '/story');
                      },
                child: Text(currentEmotionIndex < widget.emotions.length - 1
                    ? 'Next'
                    : 'Go to Stories'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
