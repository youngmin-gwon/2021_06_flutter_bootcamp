import 'package:flutter/material.dart';

class AnimateMePlease extends StatelessWidget {
  const AnimateMePlease({
    Key? key,
    required this.color,
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      width: 200,
      height: 200,
      child: const Center(
        child: Text(
          "This can be anything.",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
