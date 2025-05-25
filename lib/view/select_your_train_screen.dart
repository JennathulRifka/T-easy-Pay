import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:teasypay_kd/components/floatingBottomBar.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/date_pssngr_detail.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/tab-bar/one_way.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/tab-bar/return_way.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/train_routes_selector.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/tab-bar/train_selector_tab_bar.dart';
import 'package:teasypay_kd/viewmodels/train_view_model.dart';

class SelectTrainScreen extends StatefulWidget {
  final Map<String, dynamic> searchData;
  const SelectTrainScreen({super.key, required this.searchData});

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

    // Load trains from Firestore
    Future.delayed(Duration.zero, () {
      final from = widget.searchData['fromStation'] as String;
      final to = widget.searchData['toStation'] as String;

      context.read<TrainViewModel>().loadTrains(
            departure: from,
            arrival: to,
          );
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _onTrainSelected(String trainId) {
    context.read<TrainViewModel>().selectTrain(trainId);
    context.push('/trainDetails/$trainId');
  }

  void _handleNavTap(int index) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/search');
        break;
      case 2:
        // mic action
        break;
      case 3:
        context.go('/profile');
        break;
      case 4:
        context.go('/menu');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          width: 36,
          height: 36,
          margin: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            color: Colors.amber,
            shape: BoxShape.circle,
          ),
          child: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(
              Icons.arrow_back,
              size: 25,
              weight: 800,
              color: Colors.black,
            ),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
          ),
        ),
        title: const Text(
          "Select your train",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications, color: Colors.black),
          ),
        ],
      ),

      /// 🟡 Add Stack to position bottom nav bar
      body: Stack(
        children: [
          /// Main scrollable content
          Padding(
            padding: const EdgeInsets.only(bottom: 90),
            child: Column(
              children: [
                const TrainRoutesSelector(),
                const DatePssngrDetail(),
                const Padding(
                  padding: EdgeInsets.only(left: 12, top: 3, bottom: 3),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Select a train and proceed",
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                TrainSelectorTabBar(controller: _tabController),
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      OneWay(onTrainSelected: _onTrainSelected),
                      ReturnWay(onTrainSelected: _onTrainSelected),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 🟡 Fixed floating nav bar
          Positioned(
            bottom: 10,
            left: 20,
            right: 20,
            child: FloatingBottomBar(
              selectedIndex: 1, // Assuming "search" is tab 1
              onItemTapped: _handleNavTap,
            ),
          ),
        ],
      ),
    );
  }
}
