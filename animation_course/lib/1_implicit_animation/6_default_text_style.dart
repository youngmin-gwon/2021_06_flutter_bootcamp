import 'package:animation_course/1_implicit_animation/101_demo_button.dart';
import 'package:animation_course/1_implicit_animation/104_style.dart';
import 'package:flutter/material.dart';

class DefaultTextStyleExample extends StatefulWidget {
  const DefaultTextStyleExample({Key? key}) : super(key: key);

  @override
  _DefaultTextStyleExampleState createState() =>
      _DefaultTextStyleExampleState();
}

class _DefaultTextStyleExampleState extends State<DefaultTextStyleExample> {
  static const _firstFontSize = 28.0;
  static const _secondFontSize = 64.0;

  static const _firstColor = sunset;
  static const _secondColor = darkBlue;

  static const _firstFont = 'OpenSans';
  static const _secondFont = 'LiuJianMaoCao';

  static const _firstSpacing = 1.0;
  static const _secondSpacing = 10.0;

  static const _firstBackgroundColor = Colors.transparent;
  static const _secondBackgroundColor = Colors.grey;

  static const _firstWeight = FontWeight.w200;
  static const _secondWeight = FontWeight.bold;

  var _fontSize = _firstFontSize;
  var _color = _firstColor;
  var _font = _firstFont;
  var _letterSpacing = _firstSpacing;
  var _backgroundColor = _firstBackgroundColor;
  var _weight = _firstWeight;

  void _animateSize() {
    setState(() {
      _fontSize =
          _fontSize == _firstFontSize ? _secondFontSize : _firstFontSize;
    });
  }

  void _animateColor() {
    setState(() {
      _color = _color == _firstColor ? _secondColor : _firstColor;
    });
  }

  void _animateFont() {
    setState(() {
      _font = _font == _firstFont ? _secondFont : _firstFont;
    });
  }

  void _animateSpacing() {
    setState(() {
      _letterSpacing =
          _letterSpacing == _firstSpacing ? _secondSpacing : _firstSpacing;
    });
  }

  void _animateBackground() {
    setState(() {
      _backgroundColor = _backgroundColor == _firstBackgroundColor
          ? _secondBackgroundColor
          : _firstBackgroundColor;
    });
  }

  void _animateWeight() {
    setState(() {
      _weight = _weight == _firstWeight ? _secondWeight : _firstWeight;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 500),
              style: TextStyle(
                fontSize: _fontSize,
                fontWeight: _weight,
                color: _color,
                backgroundColor: _backgroundColor,
                fontFamily: _font,
                letterSpacing: _letterSpacing,
              ),
              curve: Curves.ease,
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Animate"),
              ),
            ),
          ),
        ),
        Expanded(
            child: GridView.count(
          crossAxisCount: 3,
          children: [
            DemoButton(
              onPressed: _animateSize,
              label: "Size",
            ),
            DemoButton(
              onPressed: _animateSpacing,
              label: "Space",
            ),
            DemoButton(
              onPressed: _animateFont,
              label: "Font",
            ),
            DemoButton(
              onPressed: _animateWeight,
              label: "Weight",
            ),
            DemoButton(
              onPressed: _animateColor,
              label: "Color",
            ),
            DemoButton(
              onPressed: _animateBackground,
              label: "background",
            ),
          ],
        ))
      ],
    );
  }
}
