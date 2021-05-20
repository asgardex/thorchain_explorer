import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserThemeNotifier extends StateNotifier<ThemeMode> {
  SharedPreferences? _pref;
  final _key = 'userTheme';

  UserThemeNotifier() : super(ThemeMode.dark) {
    _loadFromPrefs();
  }

  Future<void> _initPrefs() async {
    if (_pref == null) _pref = await SharedPreferences.getInstance();
  }

  Future<void> _loadFromPrefs() async {
    await _initPrefs();

    final mode = _pref?.getString(_key) ?? true;
    state = (mode == 'LIGHT') ? ThemeMode.light : ThemeMode.dark;
  }

  Future<void> _saveToPrefs() async {
    await _initPrefs();
    _pref?.setString(_key, (state == ThemeMode.light ? 'LIGHT' : 'DARK'));
  }

  void toggle(ThemeMode mode) {
    state = mode;
    _saveToPrefs();
  }
}
