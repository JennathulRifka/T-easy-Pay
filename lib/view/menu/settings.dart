import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import '../../providers/theme_provider.dart';
import '../../providers/language_provider.dart';
import '../../utils/app_localizations.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Settings state
  bool voiceCommands = true;
  bool notifications = true;
  bool sound = true;
  bool vibrate = true;
  String fontStyle = 'Default';
  String fontSize = 'Medium';
  String fontColor = 'Default';
  String notificationStyle = 'Banner';

  // Store initial values for reset functionality
  late final Map<String, dynamic> _initialValues;

  @override
  void initState() {
    super.initState();
    // Store initial values for reset
    _initialValues = {
      'voiceCommands': voiceCommands,
      'notifications': notifications,
      'sound': sound,
      'vibrate': vibrate,
      'fontStyle': fontStyle,
      'fontSize': fontSize,
      'notificationStyle': notificationStyle,
    };

    // Initialize fontSize from ThemeProvider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      final newFontSize = _getFontSizeFromScale(themeProvider.textScaleFactor);
      if (newFontSize != fontSize) {
        setState(() {
          fontSize = newFontSize;
          _initialValues['fontSize'] = fontSize;
        });
      }
    });
  }

  String _getFontSizeFromScale(double scale) {
    if (scale <= 0.8) return 'Small';
    if (scale >= 1.2) return 'Large';
    return 'Medium';
  }

  void _showLanguageDialog() {
    final languageProvider = Provider.of<LanguageProvider>(
      context,
      listen: false,
    );
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = Theme.of(context).textTheme.bodyLarge?.color;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor:
                isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            title: Text(
              AppLocalizations.of(context).translate('app_language'),
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: const Text('English'),
                  leading: Radio<String>(
                    value: 'en',
                    groupValue: languageProvider.currentLocale.languageCode,
                    activeColor: const Color(0xFFFFD700),
                    onChanged: (value) {
                      if (value != null) {
                        languageProvider.setLocale(Locale(value));
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                ListTile(
                  title: const Text('සිංහල'),
                  leading: Radio<String>(
                    value: 'si',
                    groupValue: languageProvider.currentLocale.languageCode,
                    activeColor: const Color(0xFFFFD700),
                    onChanged: (value) {
                      if (value != null) {
                        languageProvider.setLocale(Locale(value));
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
    );
  }

  void _showFontSizeDialog() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = themeProvider.textColor;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor:
                isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            title: Text(
              'Select Font Size',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                  title: Text('Small', style: TextStyle(color: textColor)),
                  leading: Radio<String>(
                    value: 'Small',
                    groupValue: fontSize,
                    activeColor: const Color(0xFFFFD700),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => fontSize = value);
                        themeProvider.setFontSize(value);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                ListTile(
                  title: Text('Medium', style: TextStyle(color: textColor)),
                  leading: Radio<String>(
                    value: 'Medium',
                    groupValue: fontSize,
                    activeColor: const Color(0xFFFFD700),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => fontSize = value);
                        themeProvider.setFontSize(value);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
                ListTile(
                  title: Text('Large', style: TextStyle(color: textColor)),
                  leading: Radio<String>(
                    value: 'Large',
                    groupValue: fontSize,
                    activeColor: const Color(0xFFFFD700),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => fontSize = value);
                        themeProvider.setFontSize(value);
                        Navigator.pop(context);
                      }
                    },
                  ),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
    );
  }

  void _showColorPicker() {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = themeProvider.textColor;

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor:
                isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
            title: Text(
              'Pick Text Color',
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: ColorPicker(
                pickerColor: themeProvider.textColor,
                onColorChanged: (color) async {
                  await themeProvider.setTextColor(color);
                },
                pickerAreaHeightPercent: 0.8,
                enableAlpha: false,
                displayThumbColor: true,
                labelTypes: const [ColorLabelType.hex],
                paletteType: PaletteType.hsl,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Done',
                  style: TextStyle(
                    color: Color(0xFFFFD700),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
    );
  }

  void _resetSettings() async {
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    setState(() {
      voiceCommands = _initialValues['voiceCommands'];
      notifications = _initialValues['notifications'];
      sound = _initialValues['sound'];
      vibrate = _initialValues['vibrate'];
      fontStyle = _initialValues['fontStyle'];
      fontSize = _initialValues['fontSize'];
      notificationStyle = _initialValues['notificationStyle'];
    });

    // Reset theme-related settings
    await themeProvider.setFontSize(_initialValues['fontSize']);
    await themeProvider.resetTextColor();

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.refresh, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'Settings reset to default',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFD700),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _saveSettings() {
    // Here you would typically save to persistent storage
    // For example: SharedPreferences.getInstance().then((prefs) => ...);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.black),
            SizedBox(width: 8),
            Text(
              'Settings saved successfully',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFFFFD700),
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? const Color(0xFF1E1E1E) : Colors.white;
    final textColor = themeProvider.textColor;
    final localizations = AppLocalizations.of(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (!didPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text(
            localizations.translate('app_settings'),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          backgroundColor: backgroundColor,
          elevation: 0,
          leading: IconButton(
            icon: Container(
              decoration: const BoxDecoration(
                color: Color(0xFFFFD700),
                shape: BoxShape.circle,
              ),
              padding: const EdgeInsets.all(6),
              child: Icon(Icons.arrow_back, color: textColor, size: 16),
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(localizations.translate('system'), textColor, [
                  _buildSettingItem(
                    localizations.translate('app_language'),
                    languageProvider.languageName,
                    Icons.language,
                    textColor,
                    onTap: _showLanguageDialog,
                  ),
                  _buildSettingItem(
                    localizations.translate('voice_commands'),
                    voiceCommands
                        ? localizations.translate('on')
                        : localizations.translate('off'),
                    Icons.mic,
                    textColor,
                    onTap: () => setState(() => voiceCommands = !voiceCommands),
                  ),
                ]),
                const SizedBox(height: 16),
                _buildSection(
                  localizations.translate('appearance'),
                  textColor,
                  [
                    _buildSettingItem(
                      localizations.translate('dark_mode'),
                      themeProvider.isDarkMode
                          ? localizations.translate('on')
                          : localizations.translate('off'),
                      Icons.dark_mode,
                      textColor,
                      onTap: () async {
                        await themeProvider.toggleTheme();
                        if (!mounted) return;
                        setState(() {});
                      },
                    ),
                    _buildSettingItem(
                      localizations.translate('font'),
                      localizations.translate('default'),
                      Icons.font_download,
                      textColor,
                      onTap: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(
                  localizations.translate('accessibility'),
                  textColor,
                  [
                    _buildSettingItem(
                      localizations.translate('font_size'),
                      fontSize,
                      Icons.format_size,
                      textColor,
                      onTap: _showFontSizeDialog,
                    ),
                    _buildSettingItem(
                      localizations.translate('text_color'),
                      localizations.translate('customize'),
                      Icons.format_color_text,
                      textColor,
                      onTap: _showColorPicker,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                _buildSection(localizations.translate('alerts'), textColor, [
                  _buildSettingItem(
                    localizations.translate('allow_notifications'),
                    notifications
                        ? localizations.translate('on')
                        : localizations.translate('off'),
                    Icons.notifications,
                    textColor,
                    onTap: () => setState(() => notifications = !notifications),
                  ),
                  _buildSettingItem(
                    localizations.translate('notification_style'),
                    localizations.translate('banner'),
                    Icons.notification_important,
                    textColor,
                    onTap: () {},
                  ),
                  _buildSettingItem(
                    localizations.translate('sound'),
                    sound
                        ? localizations.translate('on')
                        : localizations.translate('off'),
                    Icons.volume_up,
                    textColor,
                    onTap: () => setState(() => sound = !sound),
                  ),
                  _buildSettingItem(
                    localizations.translate('vibrate'),
                    vibrate
                        ? localizations.translate('on')
                        : localizations.translate('off'),
                    Icons.vibration,
                    textColor,
                    onTap: () => setState(() => vibrate = !vibrate),
                  ),
                ]),
                const SizedBox(height: 24),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: _resetSettings,
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFFFD700)),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          localizations.translate('reset'),
                          style: TextStyle(
                            color:
                                isDarkMode
                                    ? Colors.white
                                    : const Color(0xFFFFD700),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: _saveSettings,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFFFFD700),
                          foregroundColor: Colors.black,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                        child: Text(
                          localizations.translate('save'),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, Color textColor, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: const Color(0xFFFFD700), width: 0.5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(children: children),
        ),
      ],
    );
  }

  Widget _buildSettingItem(
    String title,
    String value,
    IconData icon,
    Color textColor, {
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(6),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withOpacity(0.1),
                borderRadius: BorderRadius.circular(6),
              ),
              child: Icon(icon, color: const Color(0xFFFFD700), size: 16),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: TextStyle(fontSize: 13, color: textColor),
              ),
            ),
            Text(
              value,
              style: TextStyle(fontSize: 12, color: textColor.withOpacity(0.7)),
            ),
            const SizedBox(width: 2),
            Icon(
              Icons.chevron_right,
              color: textColor.withOpacity(0.7),
              size: 16,
            ),
          ],
        ),
      ),
    );
  }
}
