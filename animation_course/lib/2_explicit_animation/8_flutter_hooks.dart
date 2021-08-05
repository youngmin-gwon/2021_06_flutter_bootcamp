import 'package:animation_course/0_widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class FlutterHooksExample extends HookWidget {
  const FlutterHooksExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller = useAnimationController(
      duration: const Duration(
        milliseconds: 300,
      ),
      upperBound: 1.0,
    );

    final _animation = Tween<double>(begin: .5, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.bounceOut),
    );

    return ScaleTransition(
      scale: _animation,
      child: GestureDetector(
        onTap: () {
          if (_controller.status == AnimationStatus.completed ||
              _controller.status == AnimationStatus.forward) {
            _controller.reverse();
          } else {
            _controller.forward();
          }
        },
        child: Container(
          color: sunset,
          width: 100,
          height: 100,
          child: const Center(
            child: Text(
              "Scale",
              style: TextStyle(fontSize: 24),
            ),
          ),
        ),
      ),
    );
  }
}
