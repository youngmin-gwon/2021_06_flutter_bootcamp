import 'package:animation_course/5_more_animations/models/phrase_state.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class PhaseStateNotifier extends ChangeNotifier {
  final List<PhaseState> _phases = [];
  final List<PhaseState> _likedPhases = [];

  List<PhaseState> get phases => _phases;
  List<PhaseState> get likedPhases => _likedPhases;

  void _initiate() {
    final random = generateWordPairs();
    for (final item in random) {
      _phases.add(PhaseState(phase: item.first));
    }
  }

  void addRandomItemToList() {
    _phases.add(PhaseState(phase: generateWordPairs().first.asCamelCase));
    notifyListeners();
  }

  void addItemToList(PhaseState phrase, int index) {
    _phases.insert(index, phrase);
    notifyListeners();
  }

  void removeItemFromList(int index) {
    _phases.removeAt(index);
    notifyListeners();
  }

  int get length {
    if (_phases != null) {
      return _phases.length;
    } else {
      return 0;
    }
  }

  void likeItem(int index) {
    _phases[index].likeOrDislike();
    if (_phases[index].like == true) {
      _likedPhases.add(_phases[index]);
    } else {
      _likedPhases
          .removeWhere((phrase) => phrase.phrase == _phases[index].phrase);
    }
    notifyListeners();
  }
}
