import 'package:animation_course/2_explicit_animation/transitions/align_transition.dart';
import 'package:animation_course/2_explicit_animation/transitions/fade_transition.dart';
import 'package:animation_course/2_explicit_animation/transitions/rotate_and_scale_transition.dart';
import 'package:animation_course/2_explicit_animation/transitions/slide_transition.dart';
import 'package:flutter/material.dart';

class ExplicitAnimationExample extends StatelessWidget {
  const ExplicitAnimationExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideTransitionExample(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: const [
            AlignTransitionExample(),
            RotateAndScaleTransitionExample(),
            FadeTransitionExample(),
          ],
        ),
      ),
    );
  }
}
