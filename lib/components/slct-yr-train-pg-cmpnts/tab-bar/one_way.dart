import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teasypay_kd/components/slct-yr-train-pg-cmpnts/train_card.dart';
import 'package:teasypay_kd/viewmodels/train_view_model.dart';

class OneWay extends StatelessWidget {
  final Function(String) onTrainSelected;

  const OneWay({super.key, required this.onTrainSelected});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TrainViewModel>(context);

    if (viewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (viewModel.trains.isEmpty) {
      return Center(child: Text("No trains available."));
    }

    return ListView.builder(
      itemCount: viewModel.trains.length,
      padding: EdgeInsets.all(10),
      itemBuilder: (context, index) {
        final train = viewModel.trains[index];
        return TrainCard(train: train, onSelect: onTrainSelected);
      },
    );
  }
}
