import 'package:flutter/material.dart';

const darkBlue = Color(0xFF072448);
const teal = Color(0xFF54d2d2);
const mustard = Color(0xFFffcb00);
const sunset = Color(0xFFf8aa4b);
const salmon = Color(0xFFff6150);

ThemeData theme = ThemeData(
  primaryColor: darkBlue,
  accentColor: sunset,
);

const Color headerLoginColor = Color(0xFFAF2443);
const Color headerSignUpColor = Color(0xFFD6A000);

const Color accentButton = Colors.blue;

const MaterialColor authPageBackgroundColor = Colors.blueGrey;
const MaterialColor homePageBackgroundColor = Colors.indigo;

// background

BoxDecoration backgroundAuthDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: const [
        0.1,
        0.5,
        0.9,
      ],
      colors: [
        authPageBackgroundColor[700]!,
        authPageBackgroundColor[600]!,
        authPageBackgroundColor[400]!,
      ],
    ),
  );
}

BoxDecoration backgroundHomeDecoration() {
  return BoxDecoration(
    gradient: linearGradientHomeDecoration(),
  );
}

LinearGradient linearGradientHomeDecoration() {
  return LinearGradient(
      begin: Alignment.bottomLeft,
      end: Alignment.topRight,
      stops: const [
        0.1,
        0.5,
        0.7,
        0.9
      ],
      colors: [
        homePageBackgroundColor[800]!,
        homePageBackgroundColor[700]!,
        homePageBackgroundColor[600]!,
        homePageBackgroundColor[400]!,
      ]);
}
