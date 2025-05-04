// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider with ChangeNotifier {

  static const String LANGUAGE_KEY = 'language';
  static const String FONT_SIZE_KEY = 'fontSize';
  static const String DARK_MODE_KEY = 'darkMode';
  static const String OFFLINE_MODE_KEY = 'offlineMode';

  late SharedPreferences _prefs;

  String _currentLanguage = 'am'; // am for Amharic, en for English
  double _fontSize = 16.0;
  bool _isDarkMode = false;
  bool _isOfflineMode = false;

  // Getters
  String get currentLanguage => _currentLanguage;
  double get fontSize => _fontSize;
  bool get isDarkMode => _isDarkMode;
  bool get isOfflineMode => _isOfflineMode;

  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    
    _currentLanguage = _prefs.getString(LANGUAGE_KEY) ?? 'am';
    _fontSize = _prefs.getDouble(FONT_SIZE_KEY) ?? 16.0;
    _isDarkMode = _prefs.getBool(DARK_MODE_KEY) ?? false;
    _isOfflineMode = _prefs.getBool(OFFLINE_MODE_KEY) ?? false;
    
    notifyListeners();
  }

 
  Future<void> setLanguage(String language) async {
    _currentLanguage = language;
    await _prefs.setString(LANGUAGE_KEY, language);
    notifyListeners();
  }

 
  Future<void> setFontSize(double size) async {
    _fontSize = size;
    await _prefs.setDouble(FONT_SIZE_KEY, size);
    notifyListeners();
  }


  Future<void> setDarkMode(bool value) async {
    _isDarkMode = value;
    await _prefs.setBool(DARK_MODE_KEY, value);
    notifyListeners();
  }

  Future<void> setOfflineMode(bool value) async {
    _isOfflineMode = value;
    await _prefs.setBool(OFFLINE_MODE_KEY, value);
    notifyListeners();
  }
} 