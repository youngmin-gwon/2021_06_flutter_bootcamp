import 'package:flutter/material.dart';

class AnimationControllerExample extends StatefulWidget {
  const AnimationControllerExample({Key? key}) : super(key: key);

  @override
  _AnimationControllerExampleState createState() =>
      _AnimationControllerExampleState();
}

class _AnimationControllerExampleState extends State<AnimationControllerExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  int _count = 0;
  double _width = 0;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
    _controller.addListener(() {
      _count++;
      print("progress: ${_controller.value}");
      print("duration: ${_controller.lastElapsedDuration}");
      print("count: $_count");
      _setWidth(_controller.value * 300);
    });
    super.initState();
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
        Row(children: <Widget>[
          ElevatedButton(
            onPressed: () {
              _controller.repeat(reverse: true);
            },
            child: const Text('Repeat'),
          ),
          ElevatedButton(
            onPressed: () {
              _controller.stop();
            },
            child: const Text('Stop'),
          )
        ]),
      ],
    );
  }
}
