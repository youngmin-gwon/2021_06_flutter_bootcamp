import 'package:flutter/material.dart';

// suitable only for widgets built once or user-controlled widgets
class TweenAnimationBuilderExample extends StatefulWidget {
  const TweenAnimationBuilderExample({Key? key}) : super(key: key);

  @override
  _TweenAnimationBuilderExampleState createState() =>
      _TweenAnimationBuilderExampleState();
}

class _TweenAnimationBuilderExampleState
    extends State<TweenAnimationBuilderExample> {
  var _rValue = 0.0;
  var _gValue = 0.0;
  var _bValue = 0.0;

  Color _endColor = Colors.black;

  void _updateColor() {
    setState(() {
      _endColor = Color.fromRGBO((_rValue * 255).toInt(),
          (_gValue * 255).toInt(), (_gValue * 255).toInt(), 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder(
            tween: ColorTween(begin: Colors.white, end: _endColor),
            duration: const Duration(seconds: 1),
            builder: (BuildContext context, Color? color, Widget? child) {
              return Icon(
                Icons.apps,
                size: 124,
                color: color,
              );
            }),
        Slider(
            value: _rValue,
            activeColor: Colors.red,
            inactiveColor: Colors.red[100],
            onChanged: (value) {
              _rValue = value;
              _updateColor();
            }),
        Slider(
            value: _gValue,
            activeColor: Colors.green,
            inactiveColor: Colors.green[100],
            onChanged: (value) {
              _gValue = value;
              _updateColor();
            }),
        Slider(
            value: _bValue,
            activeColor: Colors.blue,
            inactiveColor: Colors.blue[100],
            onChanged: (value) {
              _bValue = value;
              _updateColor();
            }),
      ],
    );
  }
}
