import 'package:flutter/material.dart';

class AnimatedWidgetExample extends StatelessWidget {
  const AnimatedWidgetExample({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SlideSomething(),
    );
  }
}

class SlideSomething extends StatefulWidget {
  const SlideSomething({Key? key}) : super(key: key);

  @override
  _SlideSomethingState createState() => _SlideSomethingState();
}

class _SlideSomethingState extends State<SlideSomething>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 2));
    _controller.forward();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SlideSomethingWidget(translation: _controller),
    );
  }
}

class SlideSomethingWidget extends AnimatedWidget {
  SlideSomethingWidget({Key? key, required Animation<double> translation})
      : super(
            key: key,
            listenable: Tween<Offset>(begin: Offset(0, 0), end: Offset(0, 1))
                .animate(CurvedAnimation(
                    parent: translation, curve: Curves.bounceOut)));

  Animation<Offset> get _translation => listenable as Animation<Offset>;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: _translation.value,
      child: Container(
        color: Colors.red,
        width: 100,
        height: 100,
      ),
    );
  }
}
