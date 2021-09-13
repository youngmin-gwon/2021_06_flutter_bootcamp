import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider = ChangeNotifierProvider<ThemeChangeNotifier>(
  (ref) => ThemeChangeNotifier(),
);

class ThemeChangeNotifier extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get darkMode => _isDarkMode;

  void changeTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
