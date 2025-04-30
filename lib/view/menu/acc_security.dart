import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Security'),
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        leading: IconButton(
          icon: Container(
            decoration: BoxDecoration(
              color: Colors.yellow, // Yellow Background
              shape: BoxShape.circle,
            ),
            padding: EdgeInsets.all(8), // Adjust padding for size
            child: Icon(Icons.arrow_back, color: Colors.black),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPermissionSwitch(
              "Access Location Information",
              "Allow app to access your location for nearby stations",
              locationAccess,
              (value) => setState(() => locationAccess = value),
            ),
            const Divider(height: 32),
            _buildPermissionSwitch(
              "Access Microphone",
              "Allow app to access microphone for voice commands",
              microphoneAccess,
              (value) => setState(() => microphoneAccess = value),
            ),
            const Divider(height: 32),
            _buildPermissionSwitch(
              "Access Camera",
              "Allow app to access camera for scanning tickets",
              cameraAccess,
              (value) => setState(() => cameraAccess = value),
            ),
            const Divider(height: 32),
            _buildPermissionSwitch(
              "Access Contacts",
              "Allow app to access contacts for easy ticket sharing",
              contactsAccess,
              (value) => setState(() => contactsAccess = value),
            ),
            const Divider(height: 32),
            const SizedBox(height: 32),
            Text(
              "Note: Disabling permissions may limit some app functionality",
              style: TextStyle(
                color: Colors.deepPurple[600],
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPermissionSwitch(
      String title, String description, bool value, Function(bool) onChanged) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 4),
              Text(description, style: TextStyle(color: Colors.blueGrey[600])),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
          activeColor: Colors.yellow,
        ),
      ],
    );
  }
}
