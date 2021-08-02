import 'package:animation_course/0_widgets/widgets.dart';
import 'package:flutter/material.dart';

class AnimatedPhysicalModelExample extends StatefulWidget {
  const AnimatedPhysicalModelExample({Key? key}) : super(key: key);

  @override
  _AnimatedPhysicalModelExampleState createState() =>
      _AnimatedPhysicalModelExampleState();
}

class _AnimatedPhysicalModelExampleState
    extends State<AnimatedPhysicalModelExample> {
  static const _firstColor = sunset;
  static const _secondColor = teal;
  static const _firstShadowColor = Colors.grey;
  static const _secondShadowColor = sunset;
  static const _firstBorderRadius = 0.0;
  static const _secondBorderRadius = 50.0;
  static const _firstElevation = 5.0;
  static const _secondElevation = 20.0;

  Color _color = _firstColor;
  Color _shadowColor = _firstShadowColor;
  var _borderRadius = _firstBorderRadius;
  var _elevation = _firstElevation;

  var _isFirstState = true;

  void _changePhysicalModel() {
    setState(() {
      if (_isFirstState) {
        _changeToSecondState();
      } else {
        _changeToFirstState();
      }
      _isFirstState = !_isFirstState;
    });
  }

  void _changeToFirstState() {
    _color = _firstColor;
    _shadowColor = _firstShadowColor;
    _borderRadius = _firstBorderRadius;
    _elevation = _firstElevation;
  }

  void _changeToSecondState() {
    _color = _secondColor;
    _shadowColor = _secondShadowColor;
    _borderRadius = _secondBorderRadius;
    _elevation = _secondElevation;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnimatedPhysicalModel(
          shape: BoxShape.rectangle,
          elevation: _elevation,
          color: _color,
          shadowColor: _shadowColor,
          duration: const Duration(milliseconds: 600),
          curve: Curves.ease,
          borderRadius: BorderRadius.circular(_borderRadius),
          child: const SizedBox(
            width: 200,
            height: 200,
            child: Center(
              child: Text(
                "Animate Me Please",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ),
          ),
        ),
        DemoButton(onPressed: () => _changePhysicalModel(), label: "Change")
      ],
    );
  }
}
