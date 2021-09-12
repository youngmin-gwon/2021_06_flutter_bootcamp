import 'package:animation_course/5_more_animations/models/phrase_state.dart';
import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class PhaseStateNotifier extends ChangeNotifier {
  final List<PhraseModel> _phrases = [];
  final List<PhraseModel> _likedPhases = [];

  List<PhraseModel> get phases => _phrases;
  List<PhraseModel> get likedPhases => _likedPhases;

  void _initiate() {
    final random = generateWordPairs();
    for (final item in random) {
      _phrases.add(
        PhraseModel(phrase: item.first),
      );
    }
  }

  void addRandomItemToList() {
    _phrases.add(PhraseModel(phrase: generateWordPairs().first.asCamelCase));
    notifyListeners();
  }

  void addItemToList(PhraseModel phrase, int index) {
    _phrases.insert(index, phrase);
    notifyListeners();
  }

  void removeItemFromList(int index) {
    _phrases.removeAt(index);
    notifyListeners();
  }

  int get length {
    if (_phrases.isNotEmpty) {
      return _phrases.length;
    } else {
      return 0;
    }
  }

  void likeItem(int index) {
    _phrases[index].likeOrDislike();
    if (_phrases[index].like == true) {
      _likedPhases.add(_phrases[index]);
    } else {
      _likedPhases
          .removeWhere((phrase) => phrase.phrase == _phrases[index].phrase);
    }
    notifyListeners();
  }
}
