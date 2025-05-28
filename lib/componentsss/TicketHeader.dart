import 'package:flutter/material.dart';

class TicketHeader extends StatelessWidget {
  const TicketHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        "assets/images/logo.png",
        width: 100,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            width: 100,
            height: 50,
            color: Colors.yellow.shade700,
            child: const Center(
              child: Text("LOGO", style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          );
        },
      ),
    );
  }
}
