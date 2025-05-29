import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'dart:math';
import 'package:teasy/models/train_model.dart';

class BtnsBar extends StatefulWidget {
  final VoidCallback onCancel;
  final Train train;

  const BtnsBar({super.key, required this.onCancel, required this.train});

  @override
  State<BtnsBar> createState() => _BtnsBarState();
}

class _BtnsBarState extends State<BtnsBar> {
  Future<String> generateRandomNumberWithDelay() async {
    int randomNumber = Random().nextInt(1000);
    String randomNumberString = randomNumber.toString();
    await Future.delayed(const Duration(seconds: 2));
    return randomNumberString;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ElevatedButton(
          onPressed: widget.onCancel,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Cancel",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            String bookingId = await generateRandomNumberWithDelay();
            context.push(
              '/seatSelection',
              extra: {
                'bookingId': bookingId,
                'passengerName': "Pasindu Piyumika", // hardcoded
                'trainNo': widget.train.number,
                'startStation': widget.train.start,
                'endStation': widget.train.end,
                'date': "2025/03/03", // Fill as needed
                'departureTime': widget.train.departureTime,
                'arrivalTime': widget.train.arrivalTime,
              },
            );
          },
          style: ElevatedButton.styleFrom(
            shadowColor: Colors.black12,
            backgroundColor: Colors.amber,
            foregroundColor: Colors.black,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          child: const Text(
            "Proceed",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
