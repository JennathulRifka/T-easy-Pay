import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:teasy/components/slct-yr-train-pg-cmpnts/train_card_detail.dart';
import 'package:teasy/models/train_model.dart';
import 'package:teasy/viewmodels/train_view_model.dart';

class TrainCard extends StatelessWidget {
  final Train train;
  final Function(String) onSelect;
  const TrainCard({super.key, required this.train, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 247, 215, 1.0),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              spreadRadius: 1,
            )
          ]),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.train, color: Colors.black, size: 50),
              Icon(Icons.bookmark_border_rounded,
                  size: 45, color: Colors.amber[900])
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  //Icon(Icons.train, color: Colors.black, size: 50),
                  SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Train No: ${train.trainId}",
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.w400),
                      ),
                      Text(
                        "${train.name}",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 20),
                      ),
                      Text(
                        "${train.start} - ${train.end}",
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                  SizedBox(width: 50),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25),
                      Text(
                        "Departs: ${train.departureTime}",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Arrives: ${train.arrivalTime}",
                        style: TextStyle(
                            fontSize: 13, fontWeight: FontWeight.w800),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          TrainCardDetail(),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ConstrainedBox(
                constraints: BoxConstraints(maxHeight: 24, maxWidth: 100),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(vertical: 1, horizontal: 20),
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.black,
                  ),
                  onPressed: () {
                    //final trainId = '1005';
                    // Replace with actual selected ID
                    context.read<TrainViewModel>().selectTrain(train.trainId);
                    context.push('/trainDetails/${train.trainId}');
                  },
                  child: Text('Proceed'),
                ),
                //--- Proceed [Elvated button] --------------------------,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
