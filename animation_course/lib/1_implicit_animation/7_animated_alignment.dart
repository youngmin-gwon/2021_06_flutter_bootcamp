import 'package:animation_course/1_implicit_animation/102_animate_me_please.dart';
import 'package:animation_course/1_implicit_animation/104_style.dart';
import 'package:flutter/material.dart';

class AnimatedAlignmentExample extends StatefulWidget {
  const AnimatedAlignmentExample({Key? key}) : super(key: key);

  @override
  _AnimatedAlignmentExampleState createState() =>
      _AnimatedAlignmentExampleState();
}

class _AnimatedAlignmentExampleState extends State<AnimatedAlignmentExample> {
  Alignment _alignment = Alignment.center;

  void _changeAlignment(Alignment alignment) {
    setState(() {
      _alignment = alignment;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      AnimatedAlign(
        alignment: _alignment,
        duration: const Duration(milliseconds: 600),
        curve: Curves.ease,
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
      AlignmentButton(alignment: Alignment.center, onPressed: _changeAlignment),
      AlignmentButton(
          alignment: Alignment.centerRight, onPressed: _changeAlignment),
      AlignmentButton(
          alignment: Alignment.bottomLeft, onPressed: _changeAlignment),
      AlignmentButton(
          alignment: Alignment.bottomCenter, onPressed: _changeAlignment),
      AlignmentButton(
          alignment: Alignment.bottomRight, onPressed: _changeAlignment),
    ]);
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
