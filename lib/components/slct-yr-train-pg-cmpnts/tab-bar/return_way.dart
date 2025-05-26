import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:teasy/components/slct-yr-train-pg-cmpnts/train_card.dart';
import 'package:teasy/viewmodels/train_view_model.dart';

class ReturnWay extends StatelessWidget {
  final Function(String) onTrainSelected;

  const ReturnWay({super.key, required this.onTrainSelected});

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<TrainViewModel>(context);

    if (viewModel.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (viewModel.trains.isEmpty) {
      return Center(child: Text("No return trains available."));
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
