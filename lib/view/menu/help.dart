import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/theme_provider.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, dynamic>> _frequentQuestions = [
    {"question": "How do I book a train ticket?", "icon": Icons.train},
    {"question": "What payment methods are accepted?", "icon": Icons.payment},
    {"question": "How can I cancel my ticket?", "icon": Icons.cancel_outlined},
    {
      "question": "Is there a mobile ticket option?",
      "icon": Icons.phone_android,
    },
    {"question": "What are the baggage allowances?", "icon": Icons.luggage},
  ];

  final List<Map<String, dynamic>> _trainInfo = [
    {
      "info": "Sri Lanka Railways operates across the island",
      "icon": Icons.map_outlined,
    },
    {
      "info": "Main routes: Colombo to Kandy, Galle, Jaffna, Badulla",
      "icon": Icons.route,
    },
    {
      "info": "Three classes: 1st, 2nd, 3rd class available",
      "icon": Icons.airline_seat_recline_extra,
    },
    {"info": "Express trains available on main routes", "icon": Icons.speed},
    {
      "info": "Discounts available for children and seniors",
      "icon": Icons.discount_outlined,
    },
  ];

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textColor = themeProvider.textColor;
    final cardColor = isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: Text(
          'Help & Train Information',
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle('Train Information', Icons.train, textColor),
            const SizedBox(height: 12),
            Container(
              decoration: BoxDecoration(
                color: cardColor,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode
                        ? Colors.black.withOpacity(0.3)
                        : Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: _trainInfo
                    .map(
                      (info) => _buildInfoItem(
                        info['info'] as String,
                        info['icon'] as IconData,
                        textColor,
                      ),
                    )
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(
              'Frequently Asked Questions',
              Icons.help_outline,
              textColor,
            ),
            const SizedBox(height: 12),
            ..._frequentQuestions.map(
              (question) => _buildQuestionCard(
                question['question'] as String,
                question['icon'] as IconData,
                textColor,
              ),
            ),
            const SizedBox(height: 24),
            _buildSectionTitle(
                'Ask a Question', Icons.question_answer, textColor),
            const SizedBox(height: 12),
            _buildAskQuestionCard(textColor),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, IconData icon, Color textColor) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xFFFFD700), size: 24),
        const SizedBox(width: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoItem(String info, IconData icon, Color textColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDarkMode ? Colors.grey[800]! : Colors.grey[200]!;

    return Container(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: borderColor, width: 1)),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
            child: Text(
              info,
              style: TextStyle(
                fontSize: 14,
                color: textColor,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(String question, IconData icon, Color textColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;
    final shadowColor =
        isDarkMode ? Colors.black : Colors.black.withOpacity(0.05);

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: () => _showAnswer(question),
        borderRadius: BorderRadius.circular(15),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: cardColor,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: shadowColor,
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
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
                child: Text(
                  question,
                  style: TextStyle(
                    fontSize: 14,
                    color: textColor,
                    height: 1.4,
                  ),
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                color: Color(0xFFFFD700),
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAskQuestionCard(Color textColor) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;
    final hintColor = isDarkMode ? Colors.grey[400] : Colors.grey[400];
    final borderColor = isDarkMode ? Colors.grey[800]! : Colors.grey[300]!;
    final inputBgColor =
        isDarkMode ? const Color(0xFF1E1E1E) : Colors.grey[50]!;
    final shadowColor =
        isDarkMode ? Colors.black : Colors.black.withOpacity(0.05);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: shadowColor,
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _questionController,
            maxLines: 3,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: 'Type your question here...',
              hintStyle: TextStyle(color: hintColor),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(color: borderColor),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Color(0xFFFFD700)),
              ),
              filled: true,
              fillColor: inputBgColor,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              if (_questionController.text.isNotEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Your question has been submitted'),
                    backgroundColor: Colors.green[600],
                    behavior: SnackBarBehavior.floating,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                );
                _questionController.clear();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFD700),
              foregroundColor: Colors.black,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: const Text(
              'Submit Question',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _showAnswer(String question) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDarkMode ? Colors.white : Colors.black;
    final dialogBgColor = isDarkMode ? const Color(0xFF2A2A2A) : Colors.white;

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
        backgroundColor: dialogBgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        title: Row(
          children: [
            const Icon(Icons.help_outline, color: Color(0xFFFFD700)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                question,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
        content: Text(
          answer,
          style: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: textColor,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFFFFD700),
            ),
            child: const Text(
              'Got it',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}
