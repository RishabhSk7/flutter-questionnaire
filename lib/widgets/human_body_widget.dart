import 'package:flutter/material.dart';

class EmotionCard extends StatefulWidget {
  final String? emotion;
  final Function updatePosition;

  EmotionCard({required this.emotion, required this.updatePosition});

  @override
  _EmotionCardState createState() => _EmotionCardState();
}

class _EmotionCardState extends State<EmotionCard> {
  Offset? lastTappedPosition;

  void handleTap(Offset position) {
    widget.updatePosition(position);
    setState(() {
      lastTappedPosition = position;
    });
    // print("Tapped position for ${widget.emotion}: $position");
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        child: Stack(
          children: [
            Image.asset(
              'assets/images/human_body.png',
            ),
            Positioned.fill(
              child: GestureDetector(
                onTapUp: (details) => handleTap(details.localPosition),
                child: Container(color: Colors.transparent),
              ),
            ),
            if (lastTappedPosition != null)
              Positioned(
                left: lastTappedPosition!.dx - 5,
                top: lastTappedPosition!.dy - 5,
                child: Container(
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    color: Colors.blue,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
