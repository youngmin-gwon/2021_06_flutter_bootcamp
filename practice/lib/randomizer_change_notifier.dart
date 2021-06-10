import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'randomizer_change_notifier.freezed.dart';

@freezed
class RandomizerState with _$RandomizerState {
  const factory RandomizerState({
    @Default(0) int min,
    @Default(0) int max,
    int? generatedNumber,
  }) = _RandomizerState;
  const RandomizerState._();
}

class RandomizerStateNotifier extends StateNotifier<RandomizerState> {
  RandomizerStateNotifier() : super(const RandomizerState());

  final _randomGenerator = Random();

  void generateRandomNumber() {
    state = state.copyWith(
        generatedNumber:
            state.min + _randomGenerator.nextInt(1 + state.max - state.min));
  }

  void setMin(int value) {
    state = state.copyWith(min: value);
  }

  void setMax(int value) {
    state = state.copyWith(max: value);
  }
}

class RandomizerChangeNotifier extends ChangeNotifier {
  final _randomGenerator = Random();

  int? _generatedNumber;
  int? get generatedNumber => _generatedNumber;

  int min = 0, max = 0;

  void generateRandomNumber() {
    _generatedNumber = min + _randomGenerator.nextInt(1 + max - min);
    notifyListeners();
  }
}
