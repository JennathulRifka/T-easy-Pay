import 'package:flutter/material.dart';
import 'ExitLabel.dart';
import 'RowNumber.dart';
import 'SeatWidget.dart';

class SeatLayout extends StatelessWidget {
  final List<List<String>> seatStatus;
  final Function(int, int) selectSeat;

  const SeatLayout({
    super.key,
    required this.seatStatus,
    required this.selectSeat,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 8, offset: Offset(0, 4)),
        ],
      ),
      child: Column(
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [ExitLabel(), ExitLabel()]),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: ['A', 'B', '', 'C', 'D'].map((label) {
              return Expanded(
                child: Center(
                  child: label.isEmpty
                      ? const SizedBox(width: 50)
                      : Text(label, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 10),
          Column(
            children: List.generate(10, (row) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    RowNumber(number: row + 1),
                    SeatWidget(row: row, col: 0, status: seatStatus[row][0], onTap: () => selectSeat(row, 0)),
                    SeatWidget(row: row, col: 1, status: seatStatus[row][1], onTap: () => selectSeat(row, 1)),
                    const SizedBox(width: 110),
                    SeatWidget(row: row, col: 2, status: seatStatus[row][2], onTap: () => selectSeat(row, 2)),
                    SeatWidget(row: row, col: 3, status: seatStatus[row][3], onTap: () => selectSeat(row, 3)),
                  ],
                ),
              );
            }),
          ),
          const SizedBox(height: 10),
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: const [ExitLabel(), ExitLabel()]),
        ],
      ),
    );
  }
}
