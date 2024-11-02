import 'package:flutter/material.dart';
import 'package:questionnairev2/models/question_model.dart';

class QuestionWidget extends StatefulWidget {
  final Question question;

  QuestionWidget({required this.question});

  @override
  _QuestionWidgetState createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  double _currentSliderValue = 3; // Default value (middle of the range)

  @override
  void initState() {
    super.initState();
    // Initialize slider value if it exists in the question
    _currentSliderValue =
        widget.question.sliderValue ?? 3; // Default to 3 if null
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.question.text),
        SliderTheme(
          data: SliderTheme.of(context).copyWith(
            trackHeight: 8.0,
            trackShape: RoundedRectSliderTrackShape(),
            activeTrackColor: Colors.purple.shade600,
            inactiveTrackColor: Colors.grey.shade300,
            thumbShape: RoundSliderThumbShape(
              enabledThumbRadius: 12.0,
              pressedElevation: 6.0,
            ),
            thumbColor: Colors.pinkAccent,
            overlayColor: Colors.pink.withOpacity(0.15),
            overlayShape: RoundSliderOverlayShape(overlayRadius: 28.0),
            tickMarkShape: RoundSliderTickMarkShape(),
            activeTickMarkColor: Colors.pinkAccent,
            inactiveTickMarkColor: Colors.grey.shade400,
            valueIndicatorShape: PaddleSliderValueIndicatorShape(),
            valueIndicatorColor: Colors.black87,
            valueIndicatorTextStyle: TextStyle(
              color: Colors.white,
              fontSize: 16.0,
            ),
          ),
          child: Slider(
            value: _currentSliderValue,
            min: 1,
            max: 5,
            divisions: 4, // Divisions for values 1-5
            label: _currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
                _currentSliderValue = value;
                widget.question.sliderValue =
                    _currentSliderValue; // Update the question with new slider value
              });
            },
          ),
        ),
      ],
    );
  }
}
