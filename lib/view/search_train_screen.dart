import 'package:flutter/material.dart';
import 'package:teasypay_kd/components/srch-train-cmpnts/offer_card.dart';
import 'package:teasypay_kd/components/srch-train-cmpnts/search_btn.dart';
import 'package:teasypay_kd/components/srch-train-cmpnts/search_train.dart';
import 'package:teasypay_kd/routes/app_routes.dart';

class SearchTrainScreen extends StatefulWidget {
  const SearchTrainScreen({super.key});

  @override
  State<SearchTrainScreen> createState() => _SearchTrainScreenState();
}

class _SearchTrainScreenState extends State<SearchTrainScreen> {
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
            'Search Train',
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
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  SearchTrain(),
                  SizedBox(height: 12),
                  SearchBtn(),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Hot Offer",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.offerDetails);
                        },
                        child: Text("See more",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: Colors.black)),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        OfferCard(imagePath: "assets/images/offer_img1.PNG"),
                        SizedBox(width: 12),
                        OfferCard(imagePath: "assets/images/offer_img1.PNG"),
                        SizedBox(width: 12),
                        OfferCard(imagePath: "assets/images/offer_img1.PNG"),
                        SizedBox(width: 12),
                        OfferCard(imagePath: "assets/images/offer_img1.PNG"),
                        SizedBox(width: 12),
                      ],
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          foregroundColor: Colors.black,
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoutes.selectTrain);
                        },
                        child: Text('Proceed'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
