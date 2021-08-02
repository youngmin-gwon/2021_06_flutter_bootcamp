import 'package:animation_course/0_widgets/widgets.dart';
import 'package:flutter/material.dart';

class AnimatedCrossFadeExample extends StatefulWidget {
  const AnimatedCrossFadeExample({Key? key}) : super(key: key);

  @override
  _AnimatedCrossFadeExampleState createState() =>
      _AnimatedCrossFadeExampleState();
}

class _AnimatedCrossFadeExampleState extends State<AnimatedCrossFadeExample> {
  var _state = CrossFadeState.showFirst;

  void _changeState() {
    setState(() {
      if (_state == CrossFadeState.showFirst) {
        _state = CrossFadeState.showSecond;
      } else {
        _state = CrossFadeState.showFirst;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        AnimatedCrossFade(
          firstChild: const AnimateMePlease(color: teal),
          secondChild: const FlutterLogo(
            size: 200,
          ),
          duration: const Duration(milliseconds: 600),
          crossFadeState: _state,
        ),
        DemoButton(onPressed: _changeState, label: "Change")
      ],
    );
  }
}
