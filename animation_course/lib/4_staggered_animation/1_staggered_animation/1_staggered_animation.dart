import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// timeDilation is top property
import 'package:flutter/scheduler.dart' show timeDilation;

class StaggeredAnimationExample extends HookWidget {
  const StaggeredAnimationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _controller =
        useAnimationController(duration: const Duration(milliseconds: 2000));

    // slows down animations by this factor to help in development.
    // timeDilation = 2.0;

    Future<void> _playAnimation() async {
      try {
        await _controller.forward().orCancel;
        await _controller.reverse().orCancel;
      } on TickerCanceled {
        print("cancelled");
      }
    }

    return GestureDetector(
      onTap: () {
        _playAnimation();
      },
      behavior: HitTestBehavior.opaque,
      child: Center(
        child: StaggerAnimation(
          controller: _controller,
        ),
      ),
    );
  }
}

class StaggerAnimation extends StatelessWidget {
  StaggerAnimation({Key? key, required this.controller})
      : canvasSize = Tween<double>(begin: 50.0, end: 200.0).animate(
            CurvedAnimation(
                parent: controller,
                curve: const Interval(0, 0.5, curve: Curves.ease))),
        size = Tween<double>(begin: 30.0, end: 200.0).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(0.5, 1.0, curve: Curves.ease))),
        rotation = Tween<double>(begin: 0, end: 4 * pi).animate(CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0,
              1,
              curve: Curves.ease,
            ))),
        borderRadius = Tween<double>(begin: 30, end: 10).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.25,
              1,
              curve: Curves.ease,
            ),
          ),
        ),
        color = ColorTween(
          begin: Colors.indigo[300],
          end: Colors.orange[400],
        ).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(
              0.500,
              0.750,
              curve: Curves.ease,
            ),
          ),
        ),
        super(key: key);

  final Animation<double> controller;
  final Animation<double> canvasSize;
  final Animation<double> size;
  final Animation<double> rotation;
  final Animation<double> borderRadius;
  final Animation<Color?> color;

  Widget _buildAnimation(BuildContext context, Widget? child) {
    return SizedBox(
      height: canvasSize.value,
      width: canvasSize.value,
      child: Transform.rotate(
          angle: rotation.value,
          child: Align(
            alignment: Alignment.topCenter,
            child: Container(
              width: size.value,
              height: size.value,
              decoration: BoxDecoration(
                color: color.value,
                borderRadius: BorderRadius.circular(borderRadius.value),
              ),
            ),
          )),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(animation: controller, builder: _buildAnimation);
  }
}
