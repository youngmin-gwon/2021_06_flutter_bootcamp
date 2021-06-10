import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/main.dart';

class RandomizerPage extends ConsumerWidget {
  RandomizerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Randomizer"),
      ),
      body: Center(child: Consumer(
        builder: (context, ref, child) {
          final randomizer = watch(randomizerProvider);
          return Text(
            randomizer.generatedNumber?.toString() ?? "Generate a Number",
            style: const TextStyle(fontSize: 42),
          );
        },
      )),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.read(randomizerProvider.notifier).generateRandomNumber();
          },
          label: const Text("Generate")),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
