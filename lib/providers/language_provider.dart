import 'package:flutter/material.dart';

class LanguageProvider with ChangeNotifier {
  Locale _currentLocale = const Locale('en');

  Locale get currentLocale => _currentLocale;

  void setLocale(Locale locale) {
    _currentLocale = locale;
    notifyListeners();
  }

  String get languageName {
    switch (_currentLocale.languageCode) {
      case 'si':
        return 'සිංහල';
      case 'en':
      default:
        return 'English';
    }
  }
}
