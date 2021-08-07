class PhaseState {
  final String _phase;
  bool _like;

  PhaseState({
    required String phase,
  })  : _phase = phase,
        _like = false;

  String get phrase => _phase;
  bool get like => _like;

  void likeOrDislike() {
    _like = !_like;
  }
}
