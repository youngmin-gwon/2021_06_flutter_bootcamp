import 'package:flutter/material.dart';

class RangeSelector extends StatefulWidget {
  RangeSelector({Key? key}) : super(key: key);

  @override
  _RangeSelectorState createState() => _RangeSelectorState();
}

class _RangeSelectorState extends State<RangeSelector> {
  int _min = 0;
  int _max = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Range"),
      ),
      body: Form(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RangeSelectorTextFormField(
                labelText: "Minimum",
                intValueSetter: (value) => _min = value,
              ),
              const SizedBox(
                height: 12,
              ),
              RangeSelectorTextFormField(
                labelText: "Maximum",
                intValueSetter: (value) => _max = value,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_forward),
        onPressed: () {
          // TODO : Validate the Form
          // TODO : Navigate to the generated page
        },
      ),
    );
  }
}

class RangeSelectorTextFormField extends StatelessWidget {
  RangeSelectorTextFormField({
    Key? key,
    required this.labelText,
    required this.intValueSetter,
  }) : super(key: key);

  final String labelText;
  void Function(int value) intValueSetter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        labelText: labelText,
      ),
      keyboardType: TextInputType.numberWithOptions(
        decimal: false,
        signed: true,
      ),
      onSaved: (newValue) => intValueSetter(int.parse(newValue ?? "")),
    );
  }
}
