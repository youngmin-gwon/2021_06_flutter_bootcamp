import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/main.dart';

class RandomizerPage extends ConsumerWidget {
  const RandomizerPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final state = watch(randomizerProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Randomzier"),
      ),
      body: Center(
        child: Text(
          state.generatedNumber?.toString() ?? "Generate a Number",
          style: const TextStyle(fontSize: 42),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.read(randomizerProvider.notifier).generateNumber();
        },
        label: const Text("Generate"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
