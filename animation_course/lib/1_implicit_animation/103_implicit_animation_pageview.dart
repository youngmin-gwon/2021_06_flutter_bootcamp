import 'package:animation_course/1_implicit_animation/100_demo_page.dart';
import 'package:animation_course/1_implicit_animation/10_tween_animation_builder.dart';
import 'package:animation_course/1_implicit_animation/3_animated_cross_fade.dart';
import 'package:animation_course/1_implicit_animation/4_animated_physical_model.dart';
import 'package:animation_course/1_implicit_animation/6_default_text_style.dart';
import 'package:animation_course/1_implicit_animation/7_animated_alignment.dart';
import 'package:animation_course/1_implicit_animation/8_animated_padding.dart';
import 'package:flutter/material.dart';

import '1_implicit_animation_game.dart';
import '2_animated_container.dart';
import '5_animated_opacitiy.dart';
import '9_animated_positioned.dart';

class ImplicitAnimationPageView extends StatelessWidget {
  const ImplicitAnimationPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        DemoPage(
          title: "Implicit Animation Game",
          child: ImplicitAnimationGamePage(),
        ),
        DemoPage(
          title: "Animated Container",
          child: AnimatedContainerExample(),
        ),
        DemoPage(
          title: "Animated Cross Fade",
          child: AnimatedCrossFadeExample(),
        ),
        DemoPage(
          title: "Animated Physical Model",
          child: AnimatedPhysicalModelExample(),
        ),
        DemoPage(
          title: "Animated Opacity",
          child: AnimatedOpacityExample(),
        ),
        DemoPage(
          title: "Default TextStyle",
          child: DefaultTextStyleExample(),
        ),
        DemoPage(
          title: "Animated Alignment",
          child: AnimatedAlignmentExample(),
        ),
        DemoPage(
          title: "Animated Padding",
          child: AnimatedPaddingExample(),
        ),
        DemoPage(
          title: "Animated Positioned",
          child: AnimatedPositionedExample(),
        ),
        DemoPage(
          title: "Tween Animation",
          child: TweenAnimationBuilderExample(),
        ),
      ],
    );
  }
}
