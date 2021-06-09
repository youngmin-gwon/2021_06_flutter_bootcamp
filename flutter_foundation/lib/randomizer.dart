import 'package:flutter/material.dart';
import 'package:flutter_foundation/main.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RandomizerPage extends ConsumerWidget {
  RandomizerPage({
    Key? key,
    // required this.min,
    // required this.max,
  }) : super(key: key);
  // final int min, max;

  // final randomGenerator = Random();

  @override
  Widget build(BuildContext context, WidgetReference ref) {
    // final generatedNumber = useState<int?>(null);
    final randomzier = ref.watch(randomizerProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text("Randomizer"),
        ),
        body: Center(
          child: Text(
            // generatedNumber.value?.toString() ?? 'Generate a number',
            randomzier.generatedNumber?.toString() ?? "Generate a number",
            // notifier.generatedNumber?.toString() ?? "Generate a number",
            // context
            //         .read<RandomizerChangeNotifier>()
            //         .generatedNumber
            //         ?.toString() ??
            //     "Generate a number",
            // 바꿔도 아무일도 일어나지 않는다?
            // => read만 하고 watch or consume 하지 않기 때문에
            style: TextStyle(fontSize: 42),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              // generatedNumber.value = min + randomGenerator.nextInt(max + 1 - min);
              // context.read<RandomizerChangeNotifier>().generateRandomNumber();
              context.read(randomizerProvider).generateRandomNumber();
            },
            label: Text("Generate")),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat);
  }
}
