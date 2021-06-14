import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:practice/main.dart';

class RangeSelectorForm extends StatelessWidget {
  const RangeSelectorForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RangeSelectorTextFormField(
            labelText: "Minimum",
            intValueSetter: (value) =>
                context.read(randomizerProvider.notifier).setMin(value),
          ),
          const SizedBox(height: 12),
          RangeSelectorTextFormField(
            labelText: "Maximum",
            intValueSetter: (value) =>
                context.read(randomizerProvider.notifier).setMax(value),
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
        border: const OutlineInputBorder(),
        labelText: labelText,
      ),
      onSaved: (newValue) => intValueSetter(int.parse(newValue ?? "")),
      validator: (value) {
        if (value == null || int.tryParse(value) == null) {
          return "Must be an integer";
        }
        return null;
      },
    );
  }
}

typedef IntValueSetter = void Function(int value);
