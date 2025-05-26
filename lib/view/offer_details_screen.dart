import 'package:flutter/material.dart';
import 'package:teasy/components/srch-train-cmpnts/offer_card.dart';

class OfferDetailsScreen extends StatefulWidget {
  const OfferDetailsScreen({super.key});

  @override
  State<OfferDetailsScreen> createState() => _OfferDetailsScreenState();
}

class _OfferDetailsScreenState extends State<OfferDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          width: 36,
          height: 36,
          margin: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              size: 25,
              weight: 600,
            ),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ),
        title: Text(
          'Offers List',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.notifications,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              OfferCard(imagePath: "assets/images/offer_img1.PNG"),
              SizedBox(height: 12),
              OfferCard(imagePath: "assets/images/offer_img1.PNG"),
              SizedBox(height: 12),
              OfferCard(imagePath: "assets/images/offer_img1.PNG"),
              SizedBox(height: 12),
              OfferCard(imagePath: "assets/images/offer_img1.PNG"),
              SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
