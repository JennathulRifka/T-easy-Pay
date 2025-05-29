import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({super.key});

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  bool showPrivacyPolicy = true;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = themeProvider.textColor;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Policies',
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
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    'Privacy Policy',
                    showPrivacyPolicy,
                    () => setState(() => showPrivacyPolicy = true),
                    textColor,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTabButton(
                    'Terms & Conditions',
                    !showPrivacyPolicy,
                    () => setState(() => showPrivacyPolicy = false),
                    textColor,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: showPrivacyPolicy
                  ? _buildPrivacyPolicy(textColor)
                  : _buildTermsAndConditions(textColor),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(
    String text,
    bool isSelected,
    VoidCallback onPressed,
    Color textColor,
  ) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final unselectedColor = isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;
    final borderColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;

    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? const Color(0xFFFFD700) : unselectedColor,
        foregroundColor: isSelected ? Colors.black : textColor.withOpacity(0.7),
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
          side: BorderSide(
            color: isSelected ? const Color(0xFFFFD700) : borderColor,
            width: 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 14,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildPrivacyPolicy(Color textColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyHeader(
              'Privacy Policy', Icons.privacy_tip_outlined, textColor),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  '1. Information We Collect',
                  'We collect personal information you provide when you create an account, book tickets, or contact us. This may include your name, email, phone number, and payment information.',
                  Icons.info_outline,
                  textColor,
                ),
                _buildSection(
                  '2. How We Use Your Information',
                  'We use your information to process bookings, provide customer support, improve our services, and send important notifications about your travel plans.',
                  Icons.security_outlined,
                  textColor,
                ),
                _buildSection(
                  '3. Data Security',
                  'We implement appropriate security measures to protect your personal information. However, no method of transmission over the Internet is 100% secure.',
                  Icons.shield_outlined,
                  textColor,
                ),
                _buildSection(
                  '4. Third-Party Services',
                  'We may use third-party services for payment processing, analytics, and other functions. These services have their own privacy policies.',
                  Icons.shield_outlined,
                  textColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTermsAndConditions(Color textColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPolicyHeader(
              'Terms & Conditions', Icons.gavel_outlined, textColor),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildSection(
                  '1. Booking and Payment',
                  'All ticket bookings are subject to availability. Payment must be completed at the time of booking. We accept various payment methods as displayed during checkout.',
                  Icons.payment_outlined,
                  textColor,
                ),
                _buildSection(
                  '2. Cancellations and Refunds',
                  'Cancellations are subject to our refund policy. Refunds may take 5-7 business days to process. Some tickets may be non-refundable as indicated during booking.',
                  Icons.cancel_outlined,
                  textColor,
                ),
                _buildSection(
                  '3. Travel Regulations',
                  'Passengers must comply with all railway regulations and laws. The railway authority reserves the right to refuse travel to any passenger violating these rules.',
                  Icons.rule_outlined,
                  textColor,
                ),
                _buildSection(
                  '4. Liability',
                  'We are not liable for delays, cancellations, or disruptions caused by circumstances beyond our control, including weather, strikes, or technical failures.',
                  Icons.warning_outlined,
                  textColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPolicyHeader(String title, IconData icon, Color textColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode
        ? const Color(0xFFFFD700).withOpacity(0.05)
        : const Color(0xFFFFD700).withOpacity(0.1);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
      ),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFFD700), size: 24),
          const SizedBox(width: 12),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    String content,
    IconData icon,
    Color textColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: const Color(0xFFFFD700), size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(
              fontSize: 14,
              color: textColor.withOpacity(0.7),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
