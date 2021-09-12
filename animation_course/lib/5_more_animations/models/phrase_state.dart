import 'package:freezed_annotation/freezed_annotation.dart';

part 'phrase_state.freezed.dart';

@freezed
class PhraseModel with _$PhraseModel {
  const PhraseModel._();
  const factory PhraseModel(
      {required String phrase, @Default(false) bool like}) = _PhraseModel;

  void likeOrDislike() {
    copyWith(
      like: !like,
    );
  }
}
