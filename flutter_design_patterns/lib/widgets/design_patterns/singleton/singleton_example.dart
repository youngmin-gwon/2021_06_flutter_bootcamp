import 'package:flutter/material.dart';
import 'package:flutter_design_patterns/constants/layout_constants.dart';
import 'package:flutter_design_patterns/design_patterns/singleton/singleton.dart';
import 'package:flutter_design_patterns/widgets/design_patterns/singleton/singleton_example_card.dart';
import 'package:flutter_design_patterns/widgets/platform_specific/platform_button.dart';

class SingletonExample extends StatefulWidget {
  const SingletonExample({Key? key}) : super(key: key);

  @override
  _SingletonExampleState createState() => _SingletonExampleState();
}

class _SingletonExampleState extends State<SingletonExample> {
  final stateList = [
    ExampleState(),
    ExampleStateByDefinition.getState(),
    ExampleStateWithoutSingleton(),
  ];

  void _setTextValues([String text = 'Singleton']) {
    for (final state in stateList) {
      state.setStateText(text);
    }
    setState(() {});
  }

  void _reset() {
    for (final state in stateList) {
      state.reset();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
        behavior: const ScrollBehavior(),
        child: SingleChildScrollView(
          padding:
              const EdgeInsets.symmetric(horizontal: LayoutConstants.paddingL),
          child: Column(
            children: [
              for (var state in stateList)
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: LayoutConstants.paddingL,
                  ),
                  child: SingletonExampleCard(
                    text: state.currentText,
                  ),
                ),
              const SizedBox(height: LayoutConstants.spaceL),
              PlatformButton(
                text: "Change states' text to 'Singleton'",
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: _setTextValues,
              ),
              PlatformButton(
                text: "Reset",
                materialColor: Colors.black,
                materialTextColor: Colors.white,
                onPressed: _reset,
              ),
              const SizedBox(height: LayoutConstants.spaceXL),
              const Text(
                'Note: change states\' text and navigate the application (e.g. go to the tab "description" or main menu, then go back to this example) to see how the Singleton state behaves!',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ));
  }
}
