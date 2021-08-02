import 'package:flutter/material.dart';

class TweenExample extends StatefulWidget {
  const TweenExample({Key? key}) : super(key: key);

  @override
  _TweenExampleState createState() => _TweenExampleState();
}

class _TweenExampleState extends State<TweenExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  ColorTween _colorTween = ColorTween(begin: Colors.red, end: Colors.green);
  Animatable<double> _curveTween = Tween<double>(begin: 0, end: 300)
      .chain(CurveTween(curve: Curves.easeOut));

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.addListener(() {
      _updateWidth();
    });
    //
    _controller.addStatusListener(_animationStatus);
    _controller.forward();
    super.initState();
  }

  void _animationStatus(AnimationStatus status) {
    print(status);
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _updateWidth() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: _curveTween.evaluate(_controller),
              height: 300,
              color: _colorTween.evaluate(_controller),
            ),
          ],
        ),
      ],
    );
  }
}
