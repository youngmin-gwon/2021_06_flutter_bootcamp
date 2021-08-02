import 'package:flutter/material.dart';

class AnimationStatusListenerExample extends StatefulWidget {
  const AnimationStatusListenerExample({Key? key}) : super(key: key);

  @override
  _AnimationStatusListenerExampleState createState() =>
      _AnimationStatusListenerExampleState();
}

class _AnimationStatusListenerExampleState
    extends State<AnimationStatusListenerExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  double _width = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.addListener(() {
      _setWidth(_controller.value * 300);
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

  void _setWidth(double value) {
    setState(() {
      _width = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: _width,
              height: 300,
              color: Colors.red,
            ),
          ],
        ),
      ],
    );
  }
}
