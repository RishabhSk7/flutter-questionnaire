import 'package:questionnairev2/models/question_model.dart';

class Emotion {
  final String name; // Name of the emotion
  final List<Question> questions; // List of questions related to this emotion

  Emotion({required this.name, required this.questions});
}
