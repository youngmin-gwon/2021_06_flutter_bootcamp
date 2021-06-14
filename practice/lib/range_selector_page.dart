import 'package:flutter/material.dart';
import 'package:practice/randomizer_page.dart';
import 'package:practice/range_selector_form.dart';

class RandomSelectorPage extends StatelessWidget {
  RandomSelectorPage({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Range"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RangeSelectorForm(
          formKey: formKey,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState?.validate() == true) {
            formKey.currentState?.save();
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const RandomizerPage()));
          }
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
