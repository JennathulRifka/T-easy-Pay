import 'package:flutter/material.dart';

class CheckoutButton extends StatelessWidget {
  final bool isEnabled;
  final VoidCallback? onPressed;

  const CheckoutButton({super.key, required this.isEnabled, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.indigo.shade900,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
        ),
        child: const Text("Checkout", style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
