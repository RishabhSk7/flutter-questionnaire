import 'package:flutter/material.dart';
import 'package:questionnairev2/models/question_model.dart';
import 'package:questionnairev2/models/user_model.dart';
import 'package:questionnairev2/widgets/human_body_widget.dart';

class StoryQuestionnairePage extends StatefulWidget {
  final List<String> stories;

  StoryQuestionnairePage({required this.stories});

  @override
  _StoryQuestionnairePageState createState() => _StoryQuestionnairePageState();
}

class _StoryQuestionnairePageState extends State<StoryQuestionnairePage> {
  int currentStoryIndex = 0;

  String? selectedEmotion;
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
    if (widget.stories.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Story Questionnaire'),
        ),
        body: Center(
          child: Text(
            'No stories available. Please ask admin to add some stories from the admin panel.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    final currentStory = widget.stories[currentStoryIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Story Questionnaire"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              currentStory,
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 20),
            EmotionCard(emotion: currentStory, updatePosition: updatePosition),
            const SizedBox(height: 20),
            const Text('What emotion do you feel?'),
            DropdownButton<String>(
              hint: const Text('Select Emotion'),
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
            const SizedBox(height: 20),
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
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: currentStoryIndex > 0
                      ? () {
                          setState(() {
                            currentStoryIndex--;
                            resetInputs();
                          });
                        }
                      : null,
                  child: Text('Previous'),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (!validateInputs()) return;

                    userModel.questions.removeWhere(
                        (question) => question.storyText == currentStory);

                    userModel.questions.add(Question(
                      storyText: currentStory,
                      selectedEmotion: selectedEmotion!,
                      intensity: intensity,
                      emotionValence: positivity!,
                      selectedBodyPosition: clickedPosition!,
                    ));

                    if (currentStoryIndex < widget.stories.length - 1) {
                      setState(() {
                        currentStoryIndex++;
                        resetInputs();
                      });
                    } else {
                      userModel.saveToFile().then((_) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          '/thankyou',
                          ModalRoute.withName('/'),
                          arguments: userModel,
                        );
                      }).catchError((error) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Failed to save user data: $error'),
                          ),
                        );
                      });
                    }
                  },
                  child: Text(currentStoryIndex < widget.stories.length - 1
                      ? 'Next'
                      : 'Finish'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void resetInputs() {
    selectedEmotion = null;
    intensity = 1.0;
    positivity = null;
    clickedPosition = null;
  }

  bool validateInputs() {
    if (selectedEmotion == null) {
      showError('Please select an emotion');
      return false;
    }
    if (clickedPosition == null) {
      showError('Please select where you feel the emotion on your body');
      return false;
    }
    if (positivity == null) {
      showError('Please select whether the emotion is positive or negative');
      return false;
    }
    return true;
  }

  void showError(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
