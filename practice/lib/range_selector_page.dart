import 'package:flutter/material.dart';
import 'package:practice/randomizer_page.dart';

import 'package:practice/range_selector_form.dart';

class RangeSelectorPage extends StatelessWidget {
  RangeSelectorPage({
    Key? key,
  }) : super(key: key);
  final formKey = GlobalKey<FormState>();

  int _min = 0;
  int _max = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Select Range")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: RangeSelectorForm(
            formKey: formKey,
            minValueSetter: (value) => _min = value,
            maxValueSetter: (value) => _max = value,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState?.validate() == true) {
            formKey.currentState?.save();
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) => RandomizerPage(min: _min, max: _max),
            ));
          }
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
