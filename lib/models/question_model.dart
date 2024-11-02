class Question {
  final String text; // The question text
  final List<String>? options; // Options for dropdown or radio buttons
  double? sliderValue; // Store the value from the slider

  Question({required this.text, this.options, this.sliderValue});
}
