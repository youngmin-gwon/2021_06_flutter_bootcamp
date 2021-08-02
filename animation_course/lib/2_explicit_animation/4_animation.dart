import 'package:flutter/material.dart';

class AnimationExample extends StatefulWidget {
  const AnimationExample({Key? key}) : super(key: key);

  @override
  _AnimationExampleState createState() => _AnimationExampleState();
}

class _AnimationExampleState extends State<AnimationExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  ColorTween _colorTween = ColorTween(begin: Colors.red, end: Colors.green);
  Animatable<double> _widthTween = Tween<double>(begin: 0, end: 300);

  late Animation<double> _widthAnimation;
  late Animation<int> _counterAnimation;

  late CurvedAnimation _curvedAnimation;

  // parent animation 역할
  late ProxyAnimation _proxyAnimation;
  // reverse animation
  late ReverseAnimation _reverseAnimation;
  // TrainHoppingAnimation: controller 2개를 대입하고 중간에 바꾸는 역할
  late TrainHoppingAnimation _trainHoppingAnimation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));

    _widthAnimation = _widthTween.animate(_controller);
    _widthAnimation.addListener(() {
      setState(() {});
    });

    // controller 를 추가하여 controller 가 forward 되는 즉시 같이 수행됨
    _counterAnimation = IntTween(begin: 0, end: 100).animate(_controller);
    _counterAnimation.addListener(() {
      print(_counterAnimation.value);
    });

    _curvedAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
      reverseCurve: Curves.easeOut,
    );

    _curvedAnimation.addStatusListener(_animationStatus);

    _controller.forward();

    super.initState();
  }

  void _animationStatus(AnimationStatus status) {
    print(status);
    if (status == AnimationStatus.completed) {
      _controller.reverse();
    } else if (status == AnimationStatus.dismissed) {
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Container(
              width: _widthTween.evaluate(_curvedAnimation),
              height: 300,
              color: _colorTween.evaluate(_controller),
            ),
          ],
        ),
      ],
    );
  }
}
