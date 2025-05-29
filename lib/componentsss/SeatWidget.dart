import 'package:flutter/material.dart';

class SeatWidget extends StatelessWidget {
  final int row;
  final int col;
  final String status;
  final VoidCallback onTap;

  const SeatWidget({
    super.key,
    required this.row,
    required this.col,
    required this.status,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color seatColor = status == "available"
        ? Colors.white
        : status == "selected"
            ? Colors.yellow.shade700
            : Colors.yellow.shade400;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: seatColor,
          border: Border.all(color: Colors.yellow.shade700, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "${String.fromCharCode(65 + col)}${row + 1}",
            style: TextStyle(
              color: seatColor == Colors.white ? Colors.black : Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}
