import 'package:flutter/material.dart';
import 'package:questionnairev2/models/emotion_model.dart';
import 'package:questionnairev2/models/user_model.dart';
import 'package:questionnairev2/widgets/human_body_widget.dart';
import 'package:questionnairev2/widgets/question_widget.dart';

class EmotionQuestionnairePage extends StatefulWidget {
  final List<String> emotions;

  EmotionQuestionnairePage({required this.emotions});

  @override
  _EmotionQuestionnairePageState createState() =>
      _EmotionQuestionnairePageState();
}

class _EmotionQuestionnairePageState extends State<EmotionQuestionnairePage> {
  int currentEmotionIndex = 0;

  double intensity = 1.0;
  String? positivity;
  Offset? clickedPosition;

  late User userModel;

  void updatePosition(Offset? position) {
    setState(() {
      clickedPosition = position;
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Extract the User object from the navigator arguments
    final userArguments = ModalRoute.of(context)?.settings.arguments as User;

    // Assign the extracted user to the class variable
    setState(() {
      userModel = userArguments;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentEmotion = widget.emotions[currentEmotionIndex];

    return Scaffold(
      appBar: AppBar(title: Text(currentEmotion)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 80.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            EmotionCard(
                emotion: currentEmotion, updatePosition: updatePosition),
            const SizedBox(height: 20),
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
            // Display questions for the current emotion
            // ...currentEmotion.questions
            //     .map((question) => QuestionWidget(question: question))
            //     .toList(),
            // // Navigation buttons
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
                  onPressed: () {
                    if (userModel == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('User model has not been initialized'),
                        ),
                      );
                      return;
                    }
                    if (clickedPosition == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please select where you feel the emotion on your body'),
                        ),
                      );
                      return;
                    }

                    if (positivity == null) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text(
                              'Please select whether this emotion is positive or negative'),
                        ),
                      );
                      return;
                    }

                    userModel.emotions.removeWhere(
                        (emotion) => emotion.emotion == currentEmotion);

                    userModel.emotions.add(Emotion(
                      emotion: currentEmotion,
                      intensity: intensity,
                      emotionValence: positivity!,
                      selectedBodyPosition: clickedPosition!,
                    ));

                    currentEmotionIndex < widget.emotions.length - 1
                        ? {
                            setState(() {
                              currentEmotionIndex++;
                              intensity = 1.0;
                              positivity = null;
                              clickedPosition = null;
                            })
                          }
                        : {
                            // Navigate to the story section if it's the last emotion
                            Navigator.pushNamed(context, '/story',
                                arguments: userModel)
                          };
                  },
                  child: Text(currentEmotionIndex < widget.emotions.length - 1
                      ? 'Next'
                      : 'Go to Stories'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
