import 'package:animation_course/0_widgets/widgets.dart';
import 'package:flutter/material.dart';

class AnimatedOpacityExample extends StatefulWidget {
  const AnimatedOpacityExample({Key? key}) : super(key: key);

  @override
  _AnimatedOpacityExampleState createState() => _AnimatedOpacityExampleState();
}

class _AnimatedOpacityExampleState extends State<AnimatedOpacityExample> {
  var _sliderValue = 1.0;
  var _opacity = 1.0;

  void _changeSliderValue(double value) {
    setState(() {
      _sliderValue = value;
    });
  }

  void _changeOpacity(double value) {
    setState(() {
      _opacity = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: AnimatedOpacity(
            duration: const Duration(seconds: 1),
            opacity: _opacity,
            curve: Curves.ease,
            child: const AnimateMePlease(color: salmon),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Slider(
            activeColor: salmon,
            inactiveColor: mustard,
            value: _sliderValue,
            onChanged: _changeSliderValue,
            onChangeEnd: _changeOpacity,
          ),
        ),
      ],
    );
  }
}
