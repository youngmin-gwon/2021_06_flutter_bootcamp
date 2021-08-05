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
        children: [
          const SizedBox(height: 12),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => const ImplicitAnimationPageView(),
                ));
              },
              child: const Text("1. Implicit Animation Widgets")),
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
        ],
      )),
    );
  }
}
