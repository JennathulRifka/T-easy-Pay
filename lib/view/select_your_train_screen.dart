import 'package:flutter/material.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/date_pssngr_detail.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/tab-bar/one_way.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/tab-bar/return_way.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/train_routes_selector.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/tab-bar/train_selector_tab_bar.dart';

class SelectTrainScreen extends StatefulWidget {
  const SelectTrainScreen({super.key});

  @override
  State<SelectTrainScreen> createState() => _SelectTrainScreenState();
}

class _SelectTrainScreenState extends State<SelectTrainScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController
        .dispose(); // Always dispose controllers to avoid memory leaks
    super.dispose();
  }

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
              weight: 800,
            ),
            color: Colors.black,
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
          ),
        ),
        title: Text(
          "Select your train",
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
          ),
        ],
      ),
      body: Column(
        children: [
          TrainRoutesSelector(),
          DatePssngrDetail(),
          //--- train_routes_selector component -------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: 12,
                  top: 3,
                  bottom: 3,
                ),
                child: Text(
                  "Select a train and proceed",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
            ],
          ),
          //--- Select a train and proceed tag [Row]---------------
          TrainSelectorTabBar(controller: _tabController),
          Expanded(
            // Ensures TabBarView takes up remaining space
            child: TabBarView(
              controller: _tabController, // Explicitly setting controller
              children: [
                OneWay(),
                ReturnWay(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
