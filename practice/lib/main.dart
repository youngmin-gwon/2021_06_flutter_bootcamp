import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/randomizer_change_notifier.dart';
import 'package:practice/range_selector_page.dart';

void main() {
  runApp(AppWidget());
}

final randomizerProvider =
    StateNotifierProvider<RandomizerStateNotifier, RandomizerState>(
        (ref) => RandomizerStateNotifier());

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        title: 'Randomizer',
        home: RandomSelectorPage(),
      ),
    );
  }
}
