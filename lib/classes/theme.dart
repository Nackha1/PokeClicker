import 'package:flutter/material.dart';

class ThemeChanger with ChangeNotifier {
  ThemeData _themeData;

  ThemeChanger(this._themeData);

  ThemeData getTheme() {
    return _themeData;
  }

  void setTheme(ThemeData theme) {
    _themeData = theme;

    notifyListeners();
  }
}
