import 'package:flutter/material.dart';

class TrainRoutesSelector extends StatefulWidget {
  const TrainRoutesSelector({super.key});

  @override
  State<TrainRoutesSelector> createState() => _TrainRoutesSelectorState();
}

class _TrainRoutesSelectorState extends State<TrainRoutesSelector> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 12, right: 12, top: 5, bottom: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //---------- CMB Container ---------------------------------------
          Container(
            width: 60,
            height: 50,
            padding: EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: Colors.blueGrey[100],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'CMB',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Colombo",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            width: 50,
            height: 20,
          ),
          Image.asset(
            "assets/images/booking_train_img.png",
            width: 100,
            height: 50,
            fit: BoxFit.cover,
          ),
          SizedBox(
            width: 50,
            height: 20,
          ),
          //---------- BDL Container ---------------------------------------
          Container(
            width: 60,
            height: 50,
            padding: EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: Colors.amber[200],
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 2,
                  offset: Offset(2, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'BDL',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                Text(
                  "Badulla",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      //---------- end row ---------------------------------------

      //---------- Date/passenger count row ---------------------------------------
    );
  }
}
