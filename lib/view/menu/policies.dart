import 'package:flutter/material.dart';

class PoliciesPage extends StatefulWidget {
  const PoliciesPage({super.key});

  @override
  State<PoliciesPage> createState() => _PoliciesPageState();
}

class _PoliciesPageState extends State<PoliciesPage> {
  bool showPrivacyPolicy = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Policies'),
        backgroundColor: Colors.white,
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
      body: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () => setState(() => showPrivacyPolicy = true),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        showPrivacyPolicy ? Colors.yellow : Colors.grey[200],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Privacy Policy',
                    style: TextStyle(
                      color: showPrivacyPolicy ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () => setState(() => showPrivacyPolicy = false),
                  style: TextButton.styleFrom(
                    backgroundColor:
                        !showPrivacyPolicy ? Colors.yellow : Colors.grey[200],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Terms & Conditions',
                    style: TextStyle(
                      color: !showPrivacyPolicy ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: showPrivacyPolicy
                  ? _buildPrivacyPolicy()
                  : _buildTermsAndConditions(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrivacyPolicy() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Privacy Policy',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Last Updated: January 1, 2025',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 16),
        Text(
          '1. Information We Collect',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'We collect personal information you provide when you create an account, book tickets, or contact us. This may include your name, email, phone number, and payment information.',
        ),
        SizedBox(height: 16),
        Text(
          '2. How We Use Your Information',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'We use your information to process bookings, provide customer support, improve our services, and send important notifications about your travel plans.',
        ),
        SizedBox(height: 16),
        Text(
          '3. Data Security',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'We implement appropriate security measures to protect your personal information. However, no method of transmission over the Internet is 100% secure.',
        ),
        SizedBox(height: 16),
        Text(
          '4. Third-Party Services',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'We may use third-party services for payment processing, analytics, and other functions. These services have their own privacy policies.',
        ),
      ],
    );
  }

  Widget _buildTermsAndConditions() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms & Conditions',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 16),
        Text(
          'Last Updated: January 1, 2025',
          style: TextStyle(fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 16),
        Text(
          '1. Booking and Payment',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'All ticket bookings are subject to availability. Payment must be completed at the time of booking. We accept various payment methods as displayed during checkout.',
        ),
        SizedBox(height: 16),
        Text(
          '2. Cancellations and Refunds',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Cancellations are subject to our refund policy. Refunds may take 5-7 business days to process. Some tickets may be non-refundable as indicated during booking.',
        ),
        SizedBox(height: 16),
        Text(
          '3. Travel Regulations',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'Passengers must comply with all railway regulations and laws. The railway authority reserves the right to refuse travel to any passenger violating these rules.',
        ),
        SizedBox(height: 16),
        Text(
          '4. Liability',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        Text(
          'We are not liable for delays, cancellations, or disruptions caused by circumstances beyond our control, including weather, strikes, or technical failures.',
        ),
      ],
    );
  }
}
