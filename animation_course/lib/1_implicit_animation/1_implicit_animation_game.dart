import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class ImplicitAnimationGamePage extends StatelessWidget {
  const ImplicitAnimationGamePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Container(
          color: const Color(0xFF15202D),
          child: const ImplicitAnimationDemo(),
        ),
      ),
    );
  }
}

class ImplicitAnimationDemo extends StatefulWidget {
  const ImplicitAnimationDemo({Key? key}) : super(key: key);

  @override
  _ImplicitAnimationDemoState createState() => _ImplicitAnimationDemoState();
}

class _ImplicitAnimationDemoState extends State<ImplicitAnimationDemo> {
  static final _rng = Random();

  Color _color = Colors.red;
  double _width = 100;
  double _height = 100;
  double _radius = 50;
  Alignment _alignment = const Alignment(0.5, 0.5);

  int _score = 0;

  void _randomize() {
    _color = Color.fromARGB(
      _rng.nextInt(255),
      _rng.nextInt(255),
      _rng.nextInt(255),
      _rng.nextInt(255),
    );
    _width = _rng.nextDouble() * 120 + 10;
    _height = _rng.nextDouble() * 120 + 10;
    _radius = _rng.nextDouble() * 50 + 10;
    _alignment = Alignment(
      _rng.nextDouble() * 2 - 1,
      _rng.nextDouble() * 2 - 1,
    );
  }

  void _increaseScore() {
    _score++;
  }

  Timer? _timer;
  int _countDown = 10;
  bool _isPlaying = false;

  void _startGame() {
    _score = 0;
    _countDown = 10;
    _isPlaying = true;
    _randomize();
    _startTimer();
  }

  void _endGame() {
    _isPlaying = false;
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(
        oneSec,
        (timer) => setState(() {
              if (_countDown < 1) {
                _endGame();
                timer.cancel();
              } else {
                _countDown--;
              }
            }));
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Score: $_score",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 48,
                ),
              ),
              if (!_isPlaying)
                GestureDetector(
                  onTap: () => setState(_startGame),
                  child: const Text(
                    "Start",
                    style: TextStyle(color: Colors.white, fontSize: 28),
                  ),
                )
              else
                Text(
                  "$_countDown",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                  ),
                ),
            ],
          ),
        ),
        if (_isPlaying)
          GestureDetector(
              onTap: () => setState(() {
                    _increaseScore();
                    _randomize();
                  }),
              child: AnimatedAlign(
                curve: Curves.ease,
                duration: const Duration(milliseconds: 300),
                alignment: _alignment,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: _width,
                  height: _height,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: BorderRadius.circular(_radius),
                  ),
                ),
              ))
        else
          Container()
      ],
    );
  }
}
