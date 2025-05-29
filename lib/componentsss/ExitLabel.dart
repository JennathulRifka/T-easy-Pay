import 'package:flutter/material.dart';

class ExitLabel extends StatelessWidget {
  const ExitLabel({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text("EXIT", style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
    );
  }
}
