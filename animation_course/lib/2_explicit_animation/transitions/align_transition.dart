import 'package:animation_course/0_widgets/widgets.dart';
import 'package:flutter/material.dart';

class AlignTransitionExample extends StatefulWidget {
  const AlignTransitionExample({Key? key}) : super(key: key);

  @override
  _AlignTransitionExampleState createState() => _AlignTransitionExampleState();
}

class _AlignTransitionExampleState extends State<AlignTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<AlignmentGeometry> _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _animation = Tween<AlignmentGeometry>(
            begin: Alignment.topLeft, end: Alignment.topRight)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.bounceOut));
    _controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlignTransition(
        alignment: _animation,
        child: Container(
            color: salmon,
            width: 100,
            height: 100,
            child: const Center(
              child: Text(
                "Align",
                style: TextStyle(fontSize: 24),
              ),
            )));
  }
}
