import 'package:animation_course/0_widgets/101_implicit_animation_pageview.dart';
import 'package:animation_course/0_widgets/5_staggered_animation_pageview.dart';
import 'package:flutter/material.dart';

import '0_widgets/widgets.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animation Bootcamp',
      theme: theme,
      home: const HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Course outputs list'),
      ),
      body: Center(
          child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ImplicitAnimationPageView(),
                ));
              },
              child: const Text("1. Implicit Animation Widgets")),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ImplicitAnimationPracticePage(),
                ));
              },
              child: const Text("1-1. Implicit Animation Widgets Practice")),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ExplicitAnimationPageView(),
                ));
              },
              child: const Text("2. Explicit Animation Widgets")),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {}, child: const Text("3. Tween Curve Widgets")),
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const StaggeredAnimationPageView(),
                ));
              },
              child: const Text("4. Staggered Animation")),
        ],
      )),
    );
  }
}
