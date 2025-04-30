import 'package:flutter/material.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final _formKey = GlobalKey<FormState>();
  final _feedbackController = TextEditingController();
  String _feedbackType = "suggestion";
  bool _isSubmitting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Feedback'),
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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'We value your feedback',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text('Feedback Type'),
              Row(
                children: [
                  Radio<String>(
                    value: "suggestion",
                    groupValue: _feedbackType,
                    onChanged: (value) {
                      setState(() {
                        _feedbackType = value!;
                      });
                    },
                    activeColor: Colors.yellow,
                  ),
                  const Text('Suggestion'),
                  Radio<String>(
                    value: "error",
                    groupValue: _feedbackType,
                    onChanged: (value) {
                      setState(() {
                        _feedbackType = value!;
                      });
                    },
                    activeColor: Colors.yellow,
                  ),
                  const Text('Report Error'),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _feedbackController,
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: _feedbackType == "suggestion"
                      ? 'Your suggestion'
                      : 'Describe the error you encountered',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return _feedbackType == "suggestion"
                        ? 'Please enter your suggestion'
                        : 'Please describe the error';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isSubmitting
                      ? null
                      : () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isSubmitting = true;
                            });
                            // Simulate submission
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                _isSubmitting = false;
                              });
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Thank you for your feedback!'),
                                ),
                              );
                              _feedbackController.clear();
                            });
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    disabledBackgroundColor: Colors.yellow.withOpacity(0.5),
                  ),
                  child: _isSubmitting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Submit Feedback',
                          style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
