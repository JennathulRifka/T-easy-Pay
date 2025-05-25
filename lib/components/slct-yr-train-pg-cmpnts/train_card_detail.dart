import 'package:flutter/material.dart';

class TrainCardDetail extends StatefulWidget {
  const TrainCardDetail({super.key});

  @override
  State<TrainCardDetail> createState() => _TrainCardDetailState();
}

class _TrainCardDetailState extends State<TrainCardDetail> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8),
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
          color: Color.fromRGBO(26, 195, 0, 1.0),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Third Class",
              style: TextStyle(color: Colors.white, fontSize: 12)),
          Text("Available Seats: 3",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold)),
          Text("Price: 1,500.00",
              style: TextStyle(color: Colors.white, fontSize: 12)),
        ],
      ),
    );
  }
}
