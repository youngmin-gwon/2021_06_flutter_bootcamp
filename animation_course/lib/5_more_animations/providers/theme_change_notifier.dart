import 'package:flutter/material.dart';

class ThemeStateNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get darkMode => _isDarkMode;

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
