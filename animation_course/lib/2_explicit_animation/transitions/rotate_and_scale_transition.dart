import 'package:animation_course/0_widgets/widgets.dart';
import 'package:flutter/material.dart';

class RotateAndScaleTransitionExample extends StatefulWidget {
  const RotateAndScaleTransitionExample({Key? key}) : super(key: key);

  @override
  _RotateAndScaleTransitionExampleState createState() =>
      _RotateAndScaleTransitionExampleState();
}

class _RotateAndScaleTransitionExampleState
    extends State<RotateAndScaleTransitionExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotateAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _rotateAnimation = Tween<double>(begin: 0, end: 1).animate(
        CurvedAnimation(parent: _controller, curve: Curves.elasticInOut));
    _scaleAnimation = Tween<double>(begin: 0, end: 1)
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
    return ScaleTransition(
      scale: _scaleAnimation,
      child: RotationTransition(
        turns: _rotateAnimation,
        child: Container(
            color: mustard,
            width: 100,
            height: 100,
            child: const Center(
              child: Text(
                "Rotate",
                style: TextStyle(fontSize: 24),
              ),
            )),
      ),
    );
  }
}
