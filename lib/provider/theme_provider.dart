import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDark = false;

  bool get themeValue {
    return _isDark;
  }

  set themeValue(bool value) {
    _isDark = value;
    //storing theme value using shared preferences..
    updateThemeInPrefs(value);
    notifyListeners();
  }

  void updateThemeInPrefs(bool value) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDark', value);
  }

  void updateThemeOnStart() async {
    var prefs = await SharedPreferences.getInstance();
    var isDarkPrefs = prefs.getBool('isDark');

    if (isDarkPrefs != null) {
      _isDark = isDarkPrefs;
    } else {
      _isDark = false;
    }
    notifyListeners();
  }
}
