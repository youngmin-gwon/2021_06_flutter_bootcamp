import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// StateNotifier 확인해보면 generic 타입 받음 => immutable state 를 분리하기 위해서
// 원래 만든 것에서 state는 min, max, _generatedNumber => 따로 data class로 만들어줌

part 'randomizer_change_notifier.freezed.dart';

@freezed
class RandomizerState with _$RandomizerState {
  const RandomizerState._();
  const factory RandomizerState({
    @Default(0) int min,
    @Default(0) int max,
    int? generatedNumber,
  }) = _RandomizerState;
}

class RandomizerStateNotifier extends StateNotifier<RandomizerState> {
  RandomizerStateNotifier() : super(RandomizerState());

  final _randomGenerator = Random();

  // freezed data class 는 immutable 이기 때문에 데이터를 바로 수정할 수 없음
  void generateRandomNumber() {
    state = state.copyWith(
      generatedNumber:
          state.min + _randomGenerator.nextInt(state.max + 1 - state.min),
    );
    // state 가 변하면 listener가 자동으로 인식하여 notify해줌
  }

  void setMin(int value) {
    state = state.copyWith(min: value);
  }

  void setMax(int value) {
    state = state.copyWith(max: value);
  }
}

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
