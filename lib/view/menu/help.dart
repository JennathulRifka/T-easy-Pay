import 'package:flutter/material.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final TextEditingController _questionController = TextEditingController();
  final List<String> _frequentQuestions = [
    "How do I book a train ticket?",
    "What payment methods are accepted?",
    "How can I cancel my ticket?",
    "Is there a mobile ticket option?",
    "What are the baggage allowances?",
  ];

  final List<String> _trainInfo = [
    "Sri Lanka Railways operates across the island",
    "Main routes: Colombo to Kandy, Galle, Jaffna, Badulla",
    "Three classes: 1st, 2nd, 3rd class available",
    "Express trains available on main routes",
    "Discounts available for children and seniors",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Train Information'),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sri Lanka Train Information',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._trainInfo.map((info) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('• '),
                      Expanded(child: Text(info)),
                    ],
                  ),
                )),
            const SizedBox(height: 24),
            const Text(
              'Frequently Asked Questions',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._frequentQuestions.map((question) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: InkWell(
                    onTap: () {
                      // Show answer to question
                      _showAnswer(question);
                    },
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Expanded(child: Text(question)),
                          const Icon(Icons.chevron_right),
                        ],
                      ),
                    ),
                  ),
                )),
            const SizedBox(height: 24),
            const Text(
              'Ask a Question',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _questionController,
              maxLines: 3,
              decoration: InputDecoration(
                hintText: 'Type your question here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                if (_questionController.text.isNotEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Your question has been submitted')),
                  );
                  _questionController.clear();
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                padding: const EdgeInsets.symmetric(vertical: 16),
                minimumSize: const Size(double.infinity, 0),
              ),
              child: const Text('Submit Question',
                  style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  void _showAnswer(String question) {
    String answer = "";

    switch (question) {
      case "How do I book a train ticket?":
        answer =
            "You can book tickets through this app by selecting your route, date, and class. Payment can be made via credit/debit card or mobile wallet.";
        break;
      case "What payment methods are accepted?":
        answer =
            "We accept Visa, MasterCard, American Express, and popular mobile payment services like Dialog eZ Cash and Mobitel mCash.";
        break;
      case "How can I cancel my ticket?":
        answer =
            "Go to 'My Bookings' section, select the ticket you wish to cancel, and follow the cancellation process. Refunds will be processed within 5-7 business days.";
        break;
      case "Is there a mobile ticket option?":
        answer =
            "Yes, after booking you'll receive an e-ticket which you can show on your mobile device when boarding the train.";
        break;
      case "What are the baggage allowances?":
        answer =
            "Each passenger is allowed up to 25kg of baggage. Oversized items may require special permission and additional fees.";
        break;
      default:
        answer =
            "Thank you for your question. Our support team will get back to you shortly.";
    }

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(question),
        content: Text(answer),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK', style: TextStyle(color: Colors.yellow)),
          ),
        ],
      ),
    );
  }
}
