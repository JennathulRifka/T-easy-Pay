import 'package:flutter/material.dart';

class AccountDeletionPage extends StatefulWidget {
  const AccountDeletionPage({super.key});

  @override
  State<AccountDeletionPage> createState() => _AccountDeletionPageState();
}

class _AccountDeletionPageState extends State<AccountDeletionPage> {
  final _formKey = GlobalKey<FormState>();
  final _reasonController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _confirmDeletion = false;
  bool _isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Delete Account'),
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
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Account Deletion',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                'Deleting your account will:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('• Permanently remove all your personal data'),
                    Text('• Cancel any upcoming bookings'),
                    Text('• Delete your booking history'),
                    Text('• Remove access to all services'),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _reasonController,
                maxLines: 3,
                decoration: InputDecoration(
                  labelText: 'Reason for leaving (optional)',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Enter your password to confirm',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Checkbox(
                    value: _confirmDeletion,
                    onChanged: (value) {
                      setState(() {
                        _confirmDeletion = value!;
                      });
                    },
                    activeColor: Colors.yellow,
                  ),
                  const Expanded(
                    child: Text(
                      'I understand that this action cannot be undone and all my data will be permanently deleted',
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: (_confirmDeletion && !_isDeleting)
                      ? () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isDeleting = true;
                            });
                            // Simulate account deletion
                            Future.delayed(const Duration(seconds: 2), () {
                              Navigator.of(context)
                                  .popUntil((route) => route.isFirst);
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('Your account has been deleted'),
                                ),
                              );
                            });
                          }
                        }
                      : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    disabledBackgroundColor: Colors.red.withOpacity(0.5),
                  ),
                  child: _isDeleting
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Text('Delete Account Permanently',
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
