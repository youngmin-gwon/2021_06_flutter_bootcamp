import 'package:animation_course/0_widgets/widgets.dart';
import 'package:flutter/material.dart';

class AnimatedAlignmentPracticePage extends StatefulWidget {
  const AnimatedAlignmentPracticePage({Key? key}) : super(key: key);

  @override
  _AnimatedAlignmentPracticePageState createState() =>
      _AnimatedAlignmentPracticePageState();
}

class _AnimatedAlignmentPracticePageState
    extends State<AnimatedAlignmentPracticePage> {
  Alignment _alignment = Alignment.center;

  void _changeAlignment(Alignment alignment) {
    setState(() {
      _alignment = alignment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedAlign(
          alignment: _alignment,
          duration: const Duration(milliseconds: 1000),
          curve: Curves.bounceOut,
          child: const AnimateMePlease(color: salmon),
        ),
        AlignmentButton(
            alignment: Alignment.topLeft, onPressed: _changeAlignment),
        AlignmentButton(
            alignment: Alignment.topCenter, onPressed: _changeAlignment),
        AlignmentButton(
            alignment: Alignment.topRight, onPressed: _changeAlignment),
        AlignmentButton(
            alignment: Alignment.centerLeft, onPressed: _changeAlignment),
        AlignmentButton(
            alignment: Alignment.center, onPressed: _changeAlignment),
        AlignmentButton(
            alignment: Alignment.centerRight, onPressed: _changeAlignment),
        AlignmentButton(
            alignment: Alignment.bottomLeft, onPressed: _changeAlignment),
        AlignmentButton(
            alignment: Alignment.bottomCenter, onPressed: _changeAlignment),
        AlignmentButton(
            alignment: Alignment.bottomRight, onPressed: _changeAlignment),
      ],
    );
  }
}

typedef VoidCallbackAlignment = void Function(Alignment);

class AlignmentButton extends StatelessWidget {
  const AlignmentButton({
    Key? key,
    required this.alignment,
    required this.onPressed,
  }) : super(key: key);

  final Alignment alignment;
  final VoidCallbackAlignment onPressed;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: alignment,
      child: IconButton(
        onPressed: () {
          onPressed(alignment);
        },
        icon: const Icon(Icons.control_point),
      ),
    );
  }
}
