import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class AccountSecurityPage extends StatefulWidget {
  const AccountSecurityPage({super.key});

  @override
  State<AccountSecurityPage> createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage> {
  bool locationAccess = false;
  bool microphoneAccess = false;
  bool cameraAccess = false;
  bool contactsAccess = false;

  // Loading states for each permission
  bool isLocationLoading = false;
  bool isMicrophoneLoading = false;
  bool isCameraLoading = false;
  bool isContactsLoading = false;

  // Function to handle permission changes with backend
  Future<bool> _updatePermission(String permissionType, bool newValue) async {
    try {
      // Simulating backend call
      await Future.delayed(const Duration(seconds: 1));

      // Here you would make your actual backend call
      // Example:
      // final response = await http.post(
      //   'your-api-endpoint',
      //   body: {'permission': permissionType, 'value': newValue},
      // );

      // For demo, always return success
      // In real implementation, check response status
      return true;
    } catch (e) {
      debugPrint('Error updating permission: $e');
      return false;
    }
  }

  // Handle location permission
  Future<void> _handleLocationAccess(bool value) async {
    setState(() => isLocationLoading = true);
    final success = await _updatePermission('location', value);

    setState(() {
      isLocationLoading = false;
      if (success) {
        locationAccess = value;
        _showSuccessMessage('Location access ${value ? 'granted' : 'revoked'}');
      } else {
        _showErrorMessage('Failed to update location access');
      }
    });
  }

  // Handle microphone permission
  Future<void> _handleMicrophoneAccess(bool value) async {
    setState(() => isMicrophoneLoading = true);
    final success = await _updatePermission('microphone', value);

    setState(() {
      isMicrophoneLoading = false;
      if (success) {
        microphoneAccess = value;
        _showSuccessMessage(
          'Microphone access ${value ? 'granted' : 'revoked'}',
        );
      } else {
        _showErrorMessage('Failed to update microphone access');
      }
    });
  }

  // Handle camera permission
  Future<void> _handleCameraAccess(bool value) async {
    setState(() => isCameraLoading = true);
    final success = await _updatePermission('camera', value);

    setState(() {
      isCameraLoading = false;
      if (success) {
        cameraAccess = value;
        _showSuccessMessage('Camera access ${value ? 'granted' : 'revoked'}');
      } else {
        _showErrorMessage('Failed to update camera access');
      }
    });
  }

  // Handle contacts permission
  Future<void> _handleContactsAccess(bool value) async {
    setState(() => isContactsLoading = true);
    final success = await _updatePermission('contacts', value);

    setState(() {
      isContactsLoading = false;
      if (success) {
        contactsAccess = value;
        _showSuccessMessage('Contacts access ${value ? 'granted' : 'revoked'}');
      } else {
        _showErrorMessage('Failed to update contacts access');
      }
    });
  }

  // Show success message
  void _showSuccessMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  // Show error message
  void _showErrorMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = themeProvider.textColor;
    final warningColor =
        isDarkMode ? const Color(0xFF2A2A2A) : const Color(0xFFFFF3CD);
    final warningTextColor = isDarkMode ? Colors.white70 : Colors.grey[800]!;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Account Security',
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: isDarkMode ? const Color(0xFF1E1E1E) : Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            decoration: const BoxDecoration(
              color: Color(0xFFFFD700),
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(8),
            child: Icon(Icons.arrow_back, color: textColor, size: 20),
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildPermissionCard(
              'Location Access',
              'Allow app to access your location',
              Icons.location_on_outlined,
              locationAccess,
              _handleLocationAccess,
              textColor,
            ),
            const SizedBox(height: 12),
            _buildPermissionCard(
              'Microphone Access',
              'Allow app to access microphone',
              Icons.mic_none_rounded,
              microphoneAccess,
              _handleMicrophoneAccess,
              textColor,
            ),
            const SizedBox(height: 12),
            _buildPermissionCard(
              'Camera Access',
              'Allow app to access camera',
              Icons.camera_alt_outlined,
              cameraAccess,
              _handleCameraAccess,
              textColor,
            ),
            const SizedBox(height: 12),
            _buildPermissionCard(
              'Contacts Access',
              'Allow app to access contacts',
              Icons.contacts_outlined,
              contactsAccess,
              _handleContactsAccess,
              textColor,
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: warningColor,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: const Color(0xFFFFD700), width: 1),
              ),
              child: Row(
                children: [
                  const Icon(
                    Icons.info_outline,
                    color: Color(0xFFFFD700),
                    size: 24,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      "Note: Disabling permissions may limit some app functionality",
                      style: TextStyle(
                        color: warningTextColor,
                        fontSize: 13,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionCard(
    String title,
    String description,
    IconData icon,
    bool value,
    ValueChanged<bool> onChanged,
    Color textColor,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: value ? const Color(0xFFFFD700) : Colors.transparent,
          width: 1.5,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: const Color(0xFFFFD700), size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: textColor,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 12,
                      color: textColor.withOpacity(0.7),
                      height: 1.3,
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeColor: const Color(0xFFFFD700),
              activeTrackColor: const Color(0xFFFFD700).withOpacity(0.3),
            ),
          ],
        ),
      ),
    );
  }
}

//Example of how to integrate with your backend


// Future<bool> _updatePermission(String permissionType, bool newValue) async {
//   try {
//     final response = await http.post(
//       Uri.parse('your-api-endpoint/permissions'),
//       headers: {
//         'Authorization': 'Bearer your-auth-token',
//         'Content-Type': 'application/json',
//       },
//       body: jsonEncode({
//         'permission_type': permissionType,
//         'enabled': newValue,
//       }),
//     );

//     if (response.statusCode == 200) {
//       final data = jsonDecode(response.body);
//       return data['success'] == true;
//     }
//     return false;
//   } catch (e) {
//     debugPrint('Error updating permission: $e');
//     return false;
//   }
// }