import 'package:flutter/material.dart';

class RowNumber extends StatelessWidget {
  final int number;

  const RowNumber({super.key, required this.number});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 25,
      child: Text(
        "$number",
        textAlign: TextAlign.center,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
      ),
    );
  }
}
