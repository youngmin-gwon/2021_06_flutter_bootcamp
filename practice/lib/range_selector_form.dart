import 'package:flutter/material.dart';

class RangeSelectorForm extends StatelessWidget {
  const RangeSelectorForm({
    Key? key,
    required this.formKey,
    required this.minValueSetter,
    required this.maxValueSetter,
  }) : super(key: key);
  final GlobalKey<FormState> formKey;
  final IntValueSetter minValueSetter;
  final IntValueSetter maxValueSetter;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          RangeSelectorTextFormField(
            labelText: "Minimum",
            intValueSetter: minValueSetter,
          ),
          SizedBox(height: 12),
          RangeSelectorTextFormField(
            labelText: "Maximum",
            intValueSetter: maxValueSetter,
          ),
        ],
      ),
    );
  }
}

class RangeSelectorTextFormField extends StatelessWidget {
  const RangeSelectorTextFormField({
    Key? key,
    required this.labelText,
    required this.intValueSetter,
  }) : super(key: key);
  final String labelText;
  final IntValueSetter intValueSetter;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        border: OutlineInputBorder(),
      ),
      onSaved: (newValue) => intValueSetter(int.parse(newValue ?? "")),
      validator: (value) {
        if (value == null || int.tryParse(value) == null) {
          return "Must be an integer";
        } else {
          return null;
        }
      },
    );
  }
}

typedef IntValueSetter = void Function(int value);
