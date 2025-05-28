import 'package:flutter/material.dart';

class PaymentMethodCard extends StatelessWidget {
  final String? selectedPaymentMethod;
  final Function(String) onPaymentMethodSelected;

  const PaymentMethodCard({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Payment method", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 10),
          _buildPaymentOption("Visa", "assets/images/visa.png"),
          const SizedBox(height: 10),
          _buildPaymentOption("MasterCard", "assets/images/mastercard.png"),
        ],
      ),
    );
  }

  Widget _buildPaymentOption(String method, String imagePath) {
    return GestureDetector(
      onTap: () => onPaymentMethodSelected(method),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: selectedPaymentMethod == method ? Colors.blue.shade50 : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 30,
              errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.credit_card, size: 30, color: Colors.black),
            ),
            const SizedBox(width: 10),
            Text(method, style: const TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    );
  }
}

