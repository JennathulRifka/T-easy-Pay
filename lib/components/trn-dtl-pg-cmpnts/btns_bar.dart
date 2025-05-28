import 'package:flutter/material.dart';
import 'package:teasy/screensss/SeatSelectionScreen.dart';
import 'dart:math';

class BtnsBar extends StatefulWidget {
  final VoidCallback onCancel;

  const BtnsBar({super.key, required this.onCancel});

  @override
  State<BtnsBar> createState() => _BtnsBarState();
}

class _BtnsBarState extends State<BtnsBar> {
  Future<String> generateRandomNumberWithDelay() async {
    int randomNumber = Random().nextInt(1000);
    String randomNumberString = randomNumber.toString();
    await Future.delayed(Duration(seconds: 2));
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
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            "Cancle",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            String bookingId = await generateRandomNumberWithDelay();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SeatSelectionScreen(
                    bookingId: bookingId,
                    passengerName: "Pasindu Piyumika",
                    trainNo: "trainNo",
                    startStation: "startStation",
                    endStation: "endStation",
                    date: "date",
                    departureTime: "departureTime",
                    arrivalTime: "arrivalTime",
                  ),
                ));
          },
          style: ElevatedButton.styleFrom(
              shadowColor: Colors.black12,
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: Text(
            "Proceed",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
      ],
    );
  }
}
