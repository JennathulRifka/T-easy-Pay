import 'package:flutter/material.dart';
import 'package:teasypay_kd/models/train_model.dart';

class HeaderDtl extends StatelessWidget {
  final Train train;

  const HeaderDtl({super.key, required this.train});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(Icons.train, size: 60, color: Colors.black),
          const SizedBox(width: 10),

          // Train number and name
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Train No: ${train.trainId}",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 2),
                Text(
                  "${train.name}",
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 24),
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),

          const SizedBox(width: 10),

          // Date and time details
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "Date: 26/09/2025",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Departs: ${train.departureTime}",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
                Text(
                  "Arrives: ${train.arrivalTime}",
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
