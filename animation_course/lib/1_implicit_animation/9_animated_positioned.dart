import 'package:animation_course/0_widgets/widgets.dart';
import 'package:flutter/material.dart';

class AnimatedPositionedExample extends StatefulWidget {
  const AnimatedPositionedExample({Key? key}) : super(key: key);

  @override
  _AnimatedPositionedExampleState createState() =>
      _AnimatedPositionedExampleState();
}

class _AnimatedPositionedExampleState extends State<AnimatedPositionedExample> {
  var _isFirstState = true;

  var _left = 25.0;
  var _width = 200.0;
  var _top = 100.0;
  var _height = 100.0;

  void _changePosition() {
    if (_isFirstState) {
      _changePositionToSecondState();
    } else {
      _changePositionToFirstState();
    }
    _isFirstState = !_isFirstState;
  }

  void _changePositionToFirstState() {
    setState(() {
      _left = 25.0;
      _width = 200.0;
      _top = 100.0;
      _height = 100.0;
    });
  }

  void _changePositionToSecondState() {
    setState(() {
      _left = MediaQuery.of(context).size.width / 2 - 150.0;
      _width = 300.0;
      _top = 0.0;
      _height = MediaQuery.of(context).size.height / 2;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedPositioned(
          left: _left,
          top: _top,
          width: _width,
          height: _height,
          duration: const Duration(milliseconds: 600),
          curve: Curves.ease,
          child: const AnimateMePlease(
            color: mustard,
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: DemoButton(
            onPressed: _changePosition,
            label: 'Change',
          ),
        ),
      ],
    );
  }
}
