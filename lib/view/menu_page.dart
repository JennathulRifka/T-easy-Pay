import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';
import 'menu/settings.dart';
import 'menu/acc_information.dart';
import 'menu/acc_security.dart';
import 'menu/policies.dart';
import 'menu/help.dart';
import 'menu/feedback.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  void _showLogoutDialog(BuildContext context, Color textColor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        final isDarkMode = Theme.of(context).brightness == Brightness.dark;
        return AlertDialog(
          backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
          title: Text(
            'Logout',
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Are you sure you want to logout?',
            style: TextStyle(
              color: textColor.withOpacity(0.7),
            ),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: textColor.withOpacity(0.7),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Close the dialog
                Navigator.pop(context);
                // Perform logout
                _handleLogout(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFD700),
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text(
                'Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _handleLogout(BuildContext context) {
    // Clear any stored user data, tokens, etc.
    // Example: SharedPreferences.getInstance().then((prefs) => prefs.clear());

    // Navigate to login page and remove all previous routes
    Navigator.pushNamedAndRemoveUntil(
      context,
      '/login', // Make sure you have this route defined in your app
      (route) => false,
    );

    // Show a success message
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Successfully logged out'),
        backgroundColor: Color(0xFFFFD700),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = themeProvider.textColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        leading: Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFFFFD700),
            borderRadius: BorderRadius.circular(25),
          ),
          child: IconButton(
            icon: Icon(Icons.arrow_back, color: textColor),
            onPressed: () {},
          ),
        ),
        title: Text(
          'Menu',
          style: TextStyle(
            color: textColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: Icon(
                  Icons.notifications_outlined,
                  color: textColor,
                  size: 28,
                ),
                onPressed: () {},
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  width: 12,
                  height: 12,
                  decoration: const BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 20),
        children: [
          _buildMenuItem(
            context,
            'Account Information',
            Icons.person_outline,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccountInformationPage(),
              ),
            ),
            textColor,
          ),
          _buildMenuItem(
            context,
            'Account Security',
            Icons.lock_outline,
            () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AccountSecurityPage(),
              ),
            ),
            textColor,
          ),
          _buildMenuItem(
            context,
            'Policies',
            Icons.policy_outlined,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const PoliciesPage()),
            ),
            textColor,
          ),
          _buildMenuItem(
            context,
            'Help',
            Icons.help_outline,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HelpPage()),
            ),
            textColor,
          ),
          _buildMenuItem(
            context,
            'Feedback',
            Icons.feedback_outlined,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FeedbackPage()),
            ),
            textColor,
          ),
          _buildMenuItem(
            context,
            'Settings',
            Icons.settings_outlined,
            () => Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            ),
            textColor,
          ),
          _buildMenuItem(
            context,
            'Log Out',
            Icons.logout_outlined,
            () => _showLogoutDialog(context, textColor),
            textColor,
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context,
    String title,
    IconData icon,
    VoidCallback onTap,
    Color textColor,
  ) {
    return Column(
      children: [
        ListTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFFFD700).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(
              icon,
              color: const Color(0xFFFFD700),
              size: 20,
            ),
          ),
          title: Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
          trailing: Icon(
            Icons.chevron_right,
            color: textColor.withOpacity(0.7),
            size: 20,
          ),
          onTap: onTap,
        ),
        Divider(
          height: 1,
          color: Theme.of(context).dividerTheme.color,
        ),
      ],
    );
  }
}
