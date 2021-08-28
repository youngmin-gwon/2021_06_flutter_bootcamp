import 'package:flutter/material.dart';

class AnimatedCrossFadePracticePage extends StatefulWidget {
  const AnimatedCrossFadePracticePage({Key? key}) : super(key: key);

  @override
  _AnimatedCrossFadePracticePageState createState() =>
      _AnimatedCrossFadePracticePageState();
}

class _AnimatedCrossFadePracticePageState
    extends State<AnimatedCrossFadePracticePage> {
  var _crossFadeState = CrossFadeState.showFirst;

  void _animateCrossFade() {
    setState(() {
      if (_crossFadeState == CrossFadeState.showFirst) {
        _crossFadeState = CrossFadeState.showSecond;
      } else {
        _crossFadeState = CrossFadeState.showFirst;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedCrossFade(
          firstChild: const FlutterLogo(
            size: 200,
          ),
          secondChild: Container(
            width: 200,
            height: 200,
            alignment: Alignment.center,
            child: const Text("Faded!"),
          ),
          crossFadeState: _crossFadeState,
          duration: const Duration(milliseconds: 1000),
        ),
        ElevatedButton(
          onPressed: _animateCrossFade,
          child: const Text(
            "Animate",
          ),
        )
      ],
    );
  }
}
