import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static final Map<String, Map<String, String>> _localizedValues = {
    'en': {
      'welcome_back': 'Welcome Back!',
      'please_sign_in': 'Please sign in to continue',
      'email': 'Email',
      'password': 'Password',
      'login': 'Login',
      'dont_have_account': 'Don\'t have an account?',
      'sign_up': 'Sign Up',
      'app_settings': 'App Settings',
      'system': 'System',
      'app_language': 'App Language',
      'voice_commands': 'Voice Commands',
      'appearance': 'Appearance',
      'dark_mode': 'Dark Mode',
      'font': 'Font',
      'accessibility': 'Accessibility',
      'font_size': 'Font Size',
      'text_color': 'Text Color',
      'alerts': 'Alerts',
      'allow_notifications': 'Allow Notifications',
      'notification_style': 'Notification Style',
      'sound': 'Sound',
      'vibrate': 'Vibrate',
      'reset': 'Reset',
      'save': 'Save',
      'on': 'On',
      'off': 'Off',
      'customize': 'Customize',
      'banner': 'Banner',
      'default': 'Default',
    },
    'si': {
      'welcome_back': 'ආයුබෝවන්!',
      'please_sign_in': 'කරුණාකර පුරනය වන්න',
      'email': 'විද්‍යුත් තැපෑල',
      'password': 'මුරපදය',
      'login': 'පිවිසෙන්න',
      'dont_have_account': 'ගිණුමක් නැද්ද?',
      'sign_up': 'ලියාපදිංචි වන්න',
      'app_settings': 'යෙදුම් සැකසුම්',
      'system': 'පද්ධතිය',
      'app_language': 'යෙදුම් භාෂාව',
      'voice_commands': 'හඬ විධාන',
      'appearance': 'පෙනුම',
      'dark_mode': 'අඳුරු මාදිලිය',
      'font': 'අකුරු වර්ගය',
      'accessibility': 'ප්‍රවේශ්‍යතාව',
      'font_size': 'අකුරු විශාලත්වය',
      'text_color': 'පෙළ වර්ණය',
      'alerts': 'ඇඟවීම්',
      'allow_notifications': 'දැනුම්දීම් අවසර දෙන්න',
      'notification_style': 'දැනුම්දීම් විලාසය',
      'sound': 'ශබ්දය',
      'vibrate': 'කම්පනය',
      'reset': 'යළි පිහිටුවන්න',
      'save': 'සුරකින්න',
      'on': 'සක්‍රීයයි',
      'off': 'අක්‍රීයයි',
      'customize': 'අභිරුචිකරණය',
      'banner': 'බැනරය',
      'default': 'පෙරනිමි',
    },
  };

  String translate(String key) {
    return _localizedValues[locale.languageCode]?[key] ?? key;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'si'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}
