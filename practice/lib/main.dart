import 'package:flutter/material.dart';
import 'package:practice/range_selector_page.dart';

void main() {
  runApp(AppWidget());
}

class AppWidget extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Randomizer',
      home: RangeSelectorPage(),
    );
  }
}
