import 'package:flutter/material.dart';
import 'package:teasy/models/train_model.dart';

class StationsDetails extends StatefulWidget {
  final Train train;
  const StationsDetails({super.key, required this.train});

  @override
  State<StationsDetails> createState() => _StationsDetailsState();
}

class _StationsDetailsState extends State<StationsDetails> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: RichText(
        textAlign: TextAlign.left,
        text: TextSpan(style: TextStyle(color: Colors.black), children: [
          TextSpan(
              text: "${widget.train.start}",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          TextSpan(
              text: " > ${widget.train.stations} > ",
              style: TextStyle(fontSize: 12)),
          TextSpan(
              text: "${widget.train.end}",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        ]),
      ),
    );
  }
}
