import 'package:animation_course/0_widgets/1_demo_page.dart';
import 'package:animation_course/2_explicit_animation/1_animation_controller.dart';
import 'package:animation_course/2_explicit_animation/2_animation_status_listener.dart';
import 'package:animation_course/2_explicit_animation/3_tween.dart';
import 'package:animation_course/2_explicit_animation/4_animation.dart';
import 'package:animation_course/2_explicit_animation/5_animated_builder.dart';
import 'package:animation_course/2_explicit_animation/6_animated_widget.dart';
import 'package:animation_course/2_explicit_animation/7_built_in_explicit_animations.dart';
import 'package:animation_course/2_explicit_animation/8_flutter_hooks.dart';
import 'package:flutter/material.dart';

class ExplicitAnimationPageView extends StatelessWidget {
  const ExplicitAnimationPageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: const [
        DemoPage(
          title: "AnimationController",
          child: AnimationControllerExample(),
        ),
        DemoPage(
          title: "AnimationStatusListener",
          child: AnimationStatusListenerExample(),
        ),
        DemoPage(
          title: "Tween",
          child: TweenExample(),
        ),
        DemoPage(
          title: "Animation",
          child: AnimationExample(),
        ),
        DemoPage(
          title: "Animated Builder",
          child: AnimatedBuilderExample(),
        ),
        DemoPage(
          title: "Animated Widget",
          child: AnimatedWidgetExample(),
        ),
        DemoPage(
          title: "Explicit Animation Widgets",
          child: ExplicitAnimationExample(),
        ),
        DemoPage(
          title: "Flutter Hooks Animation",
          child: FlutterHooksExample(),
        ),
      ],
    );
  }
}
