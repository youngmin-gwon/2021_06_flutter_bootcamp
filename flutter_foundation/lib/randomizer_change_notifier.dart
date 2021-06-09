import 'dart:math';

import 'package:flutter/foundation.dart';

class RandomizerChangeNotifier extends ChangeNotifier {
  // 주제와 연관된 field를 모두 모을 수 있음
  // single responsibility를 맞추게 할 수 있음

  final _randomGenerator = Random();

  int? _generatedNumber;
  int? get generatedNumber => _generatedNumber;

  int min = 0, max = 0;

  void generateRandomNumber() {
    _generatedNumber = min + _randomGenerator.nextInt(1 + max - min);
    notifyListeners();
  }
}
