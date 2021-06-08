import 'dart:math';

import 'package:flutter/material.dart';

class RandomizerPage extends StatefulWidget {
  const RandomizerPage({
    Key? key,
    required this.min,
    required this.max,
  }) : super(key: key);
  final int min, max;

  @override
  _RandomizerPageState createState() => _RandomizerPageState();
}

class _RandomizerPageState extends State<RandomizerPage> {
  int? _generatedNumber;

  final randomGenerator = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Randomizer"),
        ),
        body: Center(
          child: Text(
            _generatedNumber?.toString() ?? 'Generate a number',
            style: TextStyle(fontSize: 42),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              setState(() {
                _generatedNumber = widget.min +
                    randomGenerator.nextInt(widget.max + 1 - widget.min);
              });
            },
            label: Text("Generate")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
