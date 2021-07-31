import 'package:animation_course/1_implicit_animation/101_demo_button.dart';
import 'package:animation_course/1_implicit_animation/102_animate_me_please.dart';
import 'package:flutter/material.dart';

import '104_style.dart';

class AnimatedPaddingExample extends StatefulWidget {
  const AnimatedPaddingExample({Key? key}) : super(key: key);

  @override
  _AnimatedPaddingExampleState createState() => _AnimatedPaddingExampleState();
}

class _AnimatedPaddingExampleState extends State<AnimatedPaddingExample> {
  static const _firstPadding = EdgeInsets.all(0);
  static const _secondPadding = EdgeInsets.all(12);

  var _padding = _firstPadding;

  var _isFirst = true;

  void _changePadding() {
    setState(() {
      if (_isFirst) {
        _padding = _secondPadding;
      } else {
        _padding = _firstPadding;
      }
      _isFirst = !_isFirst;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Container(color: mustard)),
        const Spacer(),
        Column(children: [
          AnimatedPadding(
            padding: _padding,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOut,
            child: Container(
              color: Colors.orange,
              child: const AnimateMePlease(
                color: teal,
              ),
            ),
          ),
          DemoButton(onPressed: _changePadding, label: "pad me")
        ]),
        Expanded(child: Container(color: mustard)),
      ],
    );
  }
}
