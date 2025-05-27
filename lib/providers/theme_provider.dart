import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;
  double _textScaleFactor = 1.0;
  Color _textColor = Colors.black;
  final String _fontSizeKey = 'font_size';
  final String _textColorKey = 'text_color';
  final String _themeKey = 'is_dark_mode';

  ThemeProvider() {
    _loadSettings();
  }

  bool get isDarkMode => _isDarkMode;
  double get textScaleFactor => _textScaleFactor;
  Color get textColor => _textColor;

  Future<void> toggleTheme() async {
    _isDarkMode = !_isDarkMode;
    _textColor = _isDarkMode ? Colors.white : Colors.black;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, _isDarkMode);
    await _saveTextColor();

    notifyListeners();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();

    // Load theme mode
    _isDarkMode = prefs.getBool(_themeKey) ?? false;

    // Load font size
    final savedFontSize = prefs.getString(_fontSizeKey);
    if (savedFontSize != null) {
      setFontSize(savedFontSize, notify: false);
    }

    // Load text color
    final savedColorValue = prefs.getInt(_textColorKey);
    if (savedColorValue != null) {
      _textColor = Color(savedColorValue);
    } else {
      _textColor = _isDarkMode ? Colors.white : Colors.black;
    }

    notifyListeners();
  }

  Future<void> setFontSize(String size, {bool notify = true}) async {
    switch (size) {
      case 'Small':
        _textScaleFactor = 0.8;
        break;
      case 'Medium':
        _textScaleFactor = 1.0;
        break;
      case 'Large':
        _textScaleFactor = 1.2;
        break;
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_fontSizeKey, size);

    if (notify) {
      notifyListeners();
    }
  }

  Future<void> _saveTextColor() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_textColorKey, _textColor.value);
  }

  Future<void> setTextColor(Color color) async {
    _textColor = color;
    await _saveTextColor();
    notifyListeners();
  }

  Future<void> resetTextColor() async {
    _textColor = _isDarkMode ? Colors.white : Colors.black;
    await _saveTextColor();
    notifyListeners();
  }

  ThemeData get theme {
    final baseTheme = _isDarkMode ? darkTheme : lightTheme;
    return baseTheme.copyWith(
      textTheme: baseTheme.textTheme.apply(
        bodyColor: _textColor,
        displayColor: _textColor,
      ),
      primaryTextTheme: baseTheme.primaryTextTheme.apply(
        bodyColor: _textColor,
        displayColor: _textColor,
      ),
    );
  }

  static final lightTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    primaryColor: const Color(0xFFFFD700),
    scaffoldBackgroundColor: Colors.grey[50],
    colorScheme: ColorScheme.light(
      primary: const Color(0xFFFFD700),
      secondary: Colors.grey[800]!,
      surface: Colors.white,
      background: Colors.grey[50]!,
      onPrimary: Colors.black,
      onSecondary: Colors.white,
      onSurface: Colors.black87,
      onBackground: Colors.black87,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      foregroundColor: Colors.black87,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black87),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    iconTheme: const IconThemeData(color: Colors.black87),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      titleLarge: TextStyle(),
    ),
    dividerTheme: DividerThemeData(color: Colors.grey[200], thickness: 1),
  );

  static final darkTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    primaryColor: const Color(0xFFFFD700),
    scaffoldBackgroundColor: const Color(0xFF121212),
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFFFFD700),
      secondary: Colors.grey[300]!,
      surface: const Color(0xFF1E1E1E),
      background: const Color(0xFF121212),
      onPrimary: Colors.black,
      onSecondary: Colors.black,
      onSurface: Colors.white,
      onBackground: Colors.white,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1E1E1E),
      foregroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    ),
    cardTheme: CardTheme(
      color: const Color(0xFF1E1E1E),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(),
      bodyMedium: TextStyle(),
      titleLarge: TextStyle(),
    ),
    dividerTheme: DividerThemeData(color: Colors.grey[800], thickness: 1),
  );
}
