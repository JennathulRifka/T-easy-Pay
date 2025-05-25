import 'package:flutter/material.dart';

class TrainSelectorTabBar extends StatelessWidget {
  final TabController controller;

  const TrainSelectorTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelColor: Colors.black,
      indicatorColor: Colors.amber,
      tabs: [
        Tab(text: "One way Train"),
        Tab(text: "Return Train"),
      ],
    );
  }
}
